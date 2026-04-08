# frozen_string_literal: true

require_relative "../test_helper"

class SimpleUnitTest < Minitest::Test
  def test_addition
    assert_equal 4, 2 + 2
  end

  def test_string_concatenation
    assert_equal "JunieAgent", "Junie" + "Agent"
  end
end
