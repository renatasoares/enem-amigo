require 'test_helper'
require 'rails/performance_test_help'

class MedalModelTest < ActionDispatch::PerformanceTest
  def test_creation_question
    Text.create
  end
end
