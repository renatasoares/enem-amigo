require 'test_helper'
require 'rails/performance_test_help'

class TextModelTest < ActionDispatch::PerformanceTest
  def test_creation_text
    Text.create
  end
end
