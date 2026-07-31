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
end
