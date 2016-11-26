require 'test_helper'
require 'rails/performance_test_help'

class MedalModelTest < ActionDispatch::PerformanceTest
  def test_creation_question
    Topic.create
  end
end
