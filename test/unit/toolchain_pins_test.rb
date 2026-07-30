# frozen_string_literal: true

require "minitest/autorun"

# Drift gate for toolchain version pins. `.mise.toml` is the single source of
# truth developers install from; CI and the dev Docker image carry their own
# literal pins (composite actions cannot read repo files before checkout).
# This test fails the build whenever any of those copies drifts, naming both
# files so the fix is mechanical: update them together.
#
# Intentionally asserts exact pinned values - that IS the behavior under test.
class ToolchainPinsTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def mise_pins
    @mise_pins ||= begin
      toml = File.read(File.join(ROOT, ".mise.toml"), encoding: "bom|utf-8")
      tools = toml[/\[tools\](.*)\z/m, 1] || flunk(".mise.toml has no [tools] section")
      tools.scan(/^(\w+)\s*=\s*"([^"]+)"/).to_h
    end
  end

  def read(rel)
    File.read(File.join(ROOT, rel), encoding: "bom|utf-8")
  end

  def test_mise_declares_the_full_toolchain
    assert_equal %w[bun hugo node ruby], mise_pins.keys.sort,
      ".mise.toml [tools] must pin exactly hugo, bun, node, ruby"
  end

  def test_setup_hugo_action_matches_mise
    action = read(".github/actions/setup-hugo/action.yml")

    hugo_default = action[/hugo-version:.*?default:\s*'([^']+)'/m, 1]
    assert_equal mise_pins["hugo"], hugo_default,
      "Hugo pin drift: .mise.toml=#{mise_pins["hugo"]} vs setup-hugo action.yml default=#{hugo_default}"

    bun = action[/bun-version:\s*([\d.]+)/, 1]
    assert_equal mise_pins["bun"], bun,
      "Bun pin drift: .mise.toml=#{mise_pins["bun"]} vs setup-hugo action.yml=#{bun}"

    node = action[/node-version:\s*'([^']+)'/, 1]
    assert_equal mise_pins["node"], node,
      "Node pin drift: .mise.toml=#{mise_pins["node"]} vs setup-hugo action.yml=#{node}"
  end

  def test_hugo_reusable_workflow_carries_no_duplicate_pins
    hugo_yml = read(".github/workflows/_hugo.yml")
    %w[hugo-version bun-version node-version].each do |key|
      refute_match(/#{key}:/, hugo_yml,
        "_hugo.yml declares #{key} - toolchain pins belong only in " \
        ".github/actions/setup-hugo/action.yml (call the composite instead)")
    end
  end

  def test_dev_compose_hugo_image_matches_mise
    compose = read(".dev/compose.yml")
    tag_version = compose[%r{image:\s*hugomods/hugo:\S*?-([\d.]+)\s*$}, 1]
    assert_equal mise_pins["hugo"], tag_version,
      "Hugo pin drift: .mise.toml=#{mise_pins["hugo"]} vs .dev/compose.yml hugomods image=#{tag_version}"
  end

  def test_ruby_version_file_matches_mise
    assert_equal mise_pins["ruby"], read(".ruby-version").strip,
      "Ruby pin drift: .mise.toml vs .ruby-version"
  end

  def test_workflow_ruby_versions_match_mise
    # Workflows pin the minor line ('4.0'); ruby/setup-ruby resolves the
    # latest patch. The mise pin is exact (rbenv needs that), so require the
    # workflow value to be a prefix of it - '4.0' vs 4.0.6 passes, a minor
    # bump on either side fails.
    %w[
      .github/workflows/test.yml
      .github/workflows/publish.yml
      .github/workflows/sync-and-publish.yml
      .github/workflows/link-check.yml
    ].each do |wf|
      version = read(wf)[/ruby-version:\s*'([^']+)'/, 1]
      assert version && mise_pins["ruby"].start_with?(version),
        "Ruby pin drift: .mise.toml=#{mise_pins["ruby"]} vs #{wf}=#{version.inspect}"
    end
  end
end
