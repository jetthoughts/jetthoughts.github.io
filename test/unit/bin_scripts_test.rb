# frozen_string_literal: true

require "minitest/autorun"

# Guards bin/ scripts against the sh-vs-bash portability trap that broke
# bin/test, bin/dev, bin/build (and earlier bin/dc, bin/docked) on Linux:
# `set -o pipefail` (and `set -E`) are bashisms; dash - /bin/sh on Debian
# and Ubuntu - treats a bad option to the `set` special builtin as fatal,
# so an `sh` shebang plus `pipefail` exits 2 before the first real line.
class BinScriptsTest < Minitest::Test
  BIN_DIR = File.expand_path("../../bin", __dir__)

  def shell_scripts
    Dir.children(BIN_DIR).filter_map do |name|
      path = File.join(BIN_DIR, name)
      next unless File.file?(path) && File.executable?(path)
      first_line = File.open(path, encoding: "bom|utf-8", &:readline).chomp rescue ""
      [path, first_line] if first_line.start_with?("#!")
    end
  end

  def test_sh_scripts_do_not_use_bash_only_set_options
    offenders = shell_scripts.select do |path, shebang|
      next false unless shebang.match?(%r{\benv sh\b|/bin/sh\b})
      body = File.read(path, encoding: "bom|utf-8")
      body.match?(/^\s*set\s+-[A-Za-z]*\s*-?o?\s*pipefail/) || body.match?(/^\s*set\s+-[A-Za-z]*E/)
    end
    assert_empty offenders.map(&:first),
      "sh-shebang scripts using bash-only set options (pipefail/-E) - " \
      "dash exits 2 before running a single line; change the shebang to bash"
  end

  def test_executable_scripts_have_a_shebang
    missing = Dir.children(BIN_DIR).filter_map do |name|
      path = File.join(BIN_DIR, name)
      next unless File.file?(path) && File.executable?(path)
      first_two = File.binread(path, 2)
      path unless first_two == "#!"
    end
    assert_empty missing, "executable bin/ scripts without a shebang"
  end

  # Production builds must route through bin/hugo-build: it carries the
  # PurgeCSS cold-start warm-up guard (missing hugo_stats.json purges live
  # classes - the 2026-07-19 .sr-only production incident). A bare
  # `hugo --environment production` in any other runner silently skips it.
  def test_no_bare_production_hugo_builds_outside_hugo_build
    offenders = Dir.children(BIN_DIR).filter_map do |name|
      next if %w[hugo-build build-if-stale].include?(name)
      path = File.join(BIN_DIR, name)
      next unless File.file?(path) && File.executable?(path)
      body = File.read(path, encoding: "bom|utf-8")
      invokes_hugo = body.match?(/system\(\s*["']hugo["']/) || body.match?(/^\s*hugo\s/)
      production_env = body.match?(/--environment[",\s]+["']?production/)
      path if invokes_hugo && production_env
    end
    assert_empty offenders,
      "bin/ scripts invoking bare `hugo --environment production` - route through bin/hugo-build (or bin/build-if-stale)"
  end

  # `ruby file1.rb file2.rb` executes ONLY file1 (file2 becomes ARGV) -
  # this silently disabled these very guards in the pre-push hook once.
  def test_pre_push_hook_runs_each_test_file_separately
    hook = File.expand_path("../../.githooks/pre-push", __dir__)
    skip "no pre-push hook" unless File.file?(hook)
    body = File.read(hook, encoding: "bom|utf-8")
    refute_match(/ruby\s+(?:-\S+\s+)*\S+_test\.rb\s+\S+_test\.rb/, body,
      "pre-push passes multiple test files to one ruby invocation - only the first runs")
  end

  # bin/test must honor a caller-provided HUGO_DEFAULT_PATH (bin/dtest points
  # the container at _dest/public-dtest) - a hardcoded DEST silently tests
  # the wrong tree.
  def test_bin_test_honors_preset_hugo_default_path
    body = File.read(File.join(BIN_DIR, "test"), encoding: "bom|utf-8")
    assert_match(/DEST="\$\{HUGO_DEFAULT_PATH:-/, body,
      "bin/test must default DEST from HUGO_DEFAULT_PATH")
  end
end
