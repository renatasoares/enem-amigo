require 'test_helper'
require 'rails/performance_test_help'

class TopicModelTest < ActionDispatch::PerformanceTest
  def test_creation_topic
    Topic.create
  end
end
