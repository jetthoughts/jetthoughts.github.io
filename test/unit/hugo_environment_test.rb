# frozen_string_literal: true

require_relative "../test_helper"
require "open3"
require "tempfile"

class HugoEnvironmentTest < Minitest::Test
  # -- Helpers ---------------------------------------------------------------

  PROJECT_ROOT = File.expand_path("../..", __dir__)

  # Evaluate the export lines from a build script in a clean subshell and
  # return the resulting HUGO_ENVIRONMENT value. Tests runtime execution,
  # not just file content — catches syntax errors, wrong variable names,
  # and default-value logic.
  #
  # Uses a tempfile instead of string interpolation to avoid bash variable
  # expansion issues ($ENVIRONMENT, ${ENVIRONMENT:-} in the export lines get
  # expanded by outer bash -c double quotes before eval sees them).
  def eval_export_from_script(script_rel, env_overrides = {})
    script = File.join(PROJECT_ROOT, script_rel)
    exports = File.readlines(script).grep(/^(ENVIRONMENT=|export HUGO_ENVIRONMENT)/).join

    Tempfile.create(["hugo_env_test", ".sh"]) do |f|
      # Unset ENVIRONMENT first for clean slate, then apply overrides
      f.puts "unset ENVIRONMENT"
      env_overrides.each { |k, v| f.puts "#{k}=#{v}" }
      f.puts exports
      f.puts 'echo "$HUGO_ENVIRONMENT"'
      f.flush

      stdout, stderr, status = Open3.capture3("bash", f.path)

      assert status.success?,
        "eval failed for #{script_rel}: #{stderr.strip}"
      stdout.strip
    end
  end

  # Run postcss.config.js in a clean Node process with specific env vars and
  # check whether autoprefixer is present or absent in the resolved plugins.
  # Returns true if autoprefixer is present, false if absent.
  def autoprefixer_present?(env_vars)
    # Build env string for `env` command
    env_args = env_vars.map { |k, v| "#{k}=#{v}" }
    env_args_str = env_args.map { |e| %("#{e}") }.join(" ")

    _stdout, _stderr, status = Open3.capture3(
      "bash", "-c",
      <<~SH
        cd #{PROJECT_ROOT} && \
        env #{env_args_str} node -e "
          const config = require('./postcss.config.js');
          const autoprefixer = require('autoprefixer');
          process.exit(config.plugins.includes(autoprefixer) ? 0 : 1);
        "
      SH
    )
    status.success?
  end

  # Evaluate a non-exported variable from a build script in a clean subprocess.
  # Greps the `:-` default-assignment line for the variable, writes it to a
  # tempfile with env overrides, sources via bash, and echoes the value.
  # Same isolation strategy as eval_export_from_script but for vars like
  # OUTPUT_DIR, BASE_URL, BUILD_DRAFTS that are never exported.
  def eval_var_from_script(script_rel, var_name, env_overrides = {})
    script = File.join(PROJECT_ROOT, script_rel)
    line = File.readlines(script).grep(/^#{var_name}=/).first
    raise "#{var_name} not found in #{script_rel}" unless line

    Tempfile.create(["hugo_var_test", ".sh"]) do |f|
      f.puts "unset #{var_name}"
      env_overrides.each { |k, v| f.puts "#{k}=#{v}" }
      f.puts line
      f.puts "echo \"\$#{var_name}\""
      f.flush

      stdout, stderr, status = Open3.capture3("bash", f.path)
      assert status.success?,
        "var eval failed for #{script_rel}##{var_name}: #{stderr.strip}"
      stdout.strip
    end
  end

  # Source the HUGO_ARGS construction lines from bin/hugo-build with given
  # env overrides and report whether a specific CLI flag (e.g. --baseURL,
  # --buildDrafts) is present in the built array.
  #
  # This tests the conditional-flag logic:
  #   [ -n "$BASE_URL" ] && HUGO_ARGS+=(--baseURL "$BASE_URL")
  # These conditionals are the mistake surface: if the variable check syntax
  # were wrong, the flag could be silently omitted or always included.
  def hugo_args_includes_flag?(flag, env_overrides = {})
    script = File.join(PROJECT_ROOT, "bin/hugo-build")
    lines = File.readlines(script).grep(/^(OUTPUT_DIR=|ENVIRONMENT=|export HUGO_ENVIRONMENT|BASE_URL=|BUILD_DRAFTS=|HUGO_ARGS=\(|\[ -n "\$|\[ -z)/)

    Tempfile.create(["hugo_args_test", ".sh"]) do |f|
      f.puts "unset ENVIRONMENT OUTPUT_DIR BASE_URL BUILD_DRAFTS"
      f.puts "export HUGO_ENVIRONMENT=test"
      env_overrides.each { |k, v| f.puts "#{k}=#{v}" }
      lines.each { |l| f.puts l }
      # Print each element of HUGO_ARGS on its own line for grep-friendly output
      f.puts 'printf "%s\n" "${HUGO_ARGS[@]}"'
      f.flush

      _stdout, stderr, status = Open3.capture3("bash", f.path)
      assert status.success?,
        "hugo_args eval failed: #{stderr.strip}"
      _stdout.include?(flag)
    end
  end

  # -- Tests: bin/dev --------------------------------------------------------
  # These tests evaluate the actual export lines from the scripts in a
  # clean subshell. They catch real regressions: syntax errors, renamed
  # variables, broken default-value logic — not just string presence.

  def test_bin_dev_exports_development
    result = eval_export_from_script("bin/dev")
    assert_equal "development", result,
      "bin/dev should export HUGO_ENVIRONMENT=development"
  end

  def test_bin_hugo_build_exports_from_environment_variable
    result = eval_export_from_script("bin/hugo-build", "ENVIRONMENT" => "production")
    assert_equal "production", result,
      "bin/hugo-build should export HUGO_ENVIRONMENT from ENVIRONMENT var"
  end

  def test_bin_hugo_build_defaults_to_development
    result = eval_export_from_script("bin/hugo-build")
    assert_equal "development", result,
      "bin/hugo-build should default HUGO_ENVIRONMENT to development"
  end

  def test_bin_hugo_build_defaults_on_empty_string
    result = eval_export_from_script("bin/hugo-build", "ENVIRONMENT" => "")
    assert_equal "development", result,
      "bin/hugo-build should default HUGO_ENVIRONMENT when ENVIRONMENT is empty string"
  end

  # -- Tests: bin/hugo-build OUTPUT_DIR -------------------------------------

  def test_output_dir_defaults_to_public_dev
    result = eval_var_from_script("bin/hugo-build", "OUTPUT_DIR")
    assert_equal "_dest/public-dev", result,
      "OUTPUT_DIR should default to _dest/public-dev"
  end

  def test_output_dir_respects_custom_value
    result = eval_var_from_script("bin/hugo-build", "OUTPUT_DIR",
      "OUTPUT_DIR" => "_dest/custom")
    assert_equal "_dest/custom", result,
      "OUTPUT_DIR should pass through custom value"
  end

  # -- Tests: bin/hugo-build BASE_URL ---------------------------------------

  def test_base_url_defaults_to_empty
    result = eval_var_from_script("bin/hugo-build", "BASE_URL")
    assert_equal "", result,
      "BASE_URL should default to empty string"
  end

  def test_base_url_respects_custom_value
    result = eval_var_from_script("bin/hugo-build", "BASE_URL",
      "BASE_URL" => "https://example.com")
    assert_equal "https://example.com", result,
      "BASE_URL should pass through custom value"
  end

  def test_base_url_omits_flag_when_unset
    refute hugo_args_includes_flag?("--baseURL"),
      "--baseURL flag should be absent when BASE_URL is unset"
  end

  def test_base_url_includes_flag_when_set
    assert hugo_args_includes_flag?("--baseURL",
      "BASE_URL" => "https://example.com"),
      "--baseURL flag should be present when BASE_URL is set"
  end

  # -- Tests: bin/hugo-build BUILD_DRAFTS -----------------------------------

  def test_build_drafts_defaults_to_empty
    result = eval_var_from_script("bin/hugo-build", "BUILD_DRAFTS")
    assert_equal "", result,
      "BUILD_DRAFTS should default to empty string"
  end

  def test_build_drafts_respects_custom_value
    result = eval_var_from_script("bin/hugo-build", "BUILD_DRAFTS",
      "BUILD_DRAFTS" => "true")
    assert_equal "true", result,
      "BUILD_DRAFTS should pass through custom value"
  end

  def test_build_drafts_omits_flag_when_unset
    refute hugo_args_includes_flag?("--buildDrafts"),
      "--buildDrafts flag should be absent when BUILD_DRAFTS is unset"
  end

  def test_build_drafts_includes_flag_when_set
    assert hugo_args_includes_flag?("--buildDrafts",
      "BUILD_DRAFTS" => "true"),
      "--buildDrafts flag should be present when BUILD_DRAFTS is set"
  end

  # -- Tests: postcss.config.js env consumption ------------------------------
  # These tests shell out to Node to load postcss.config.js with different
  # HUGO_ENVIRONMENT values and check which plugins resolve. This is the
  # actual integration point that broke (bun + PostCSS + missing env var).
  # The autoprefixer plugin is the oracle: it's present in production but
  # filtered out in development mode via `isDevelopment ? null : require(...)`.

  def test_postcss_resolves_correctly_with_node_available
    skip "node not available" unless system("which node > /dev/null 2>&1")
  end

  def test_postcss_skips_autoprefixer_in_development
    skip "node not available" unless system("which node > /dev/null 2>&1")
    refute autoprefixer_present?("HUGO_ENVIRONMENT" => "development"),
      "autoprefixer should be absent in development mode"
  end

  def test_postcss_includes_autoprefixer_in_production
    skip "node not available" unless system("which node > /dev/null 2>&1")
    assert autoprefixer_present?("HUGO_ENVIRONMENT" => "production"),
      "autoprefixer should be present in production mode"
  end

  def test_postcss_defaults_to_production_when_unset
    skip "node not available" unless system("which node > /dev/null 2>&1")

    _stdout, _stderr, status = Open3.capture3(
      "bash", "-c",
      <<~SH
        cd #{PROJECT_ROOT} && \
        env -u HUGO_ENVIRONMENT node -e "
          const config = require('./postcss.config.js');
          const autoprefixer = require('autoprefixer');
          process.exit(config.plugins.includes(autoprefixer) ? 0 : 1);
        "
      SH
    )
    assert status.success?,
      "autoprefixer should be present when HUGO_ENVIRONMENT is unset (production fallback)"
  end
end
