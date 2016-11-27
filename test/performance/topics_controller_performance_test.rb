require 'test_helper'
require 'rails/performance_test_help'

include SessionsHelper

class TopicsControllerPerfomanceTest < ActionDispatch::PerformanceTest
  def setup
    @topic = Topic.create(name: "Hu3 Topic", description: "Hehehe")
  end

  def test_index
    get '/topics'
  end

  def test_new_topic
    get '/topics/new'
  end

  def test_create_topic
    post "/topics", name: "Topic", description: "New topic"
  end

  def test_show
    get "/topics/#{@topic.id}"
  end
end
