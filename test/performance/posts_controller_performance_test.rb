require 'test_helper'
require 'rails/performance_test_help'

include SessionsHelper

class PostsControllerPerfomanceTest < ActionDispatch::PerformanceTest
  def setup
    @post = posts(:post01)
  end

  def test_index
    get '/posts'
  end

  def test_new_post
    get '/posts/new'
  end

  def test_create_post
    post "/posts", content: "New post"
  end

  def test_edit_post
    get "/posts/#{@post.id}/edit"
  end

  def test_update_post
    patch "/posts/#{@post.id}", content: "Modified post"
  end

  def test_delete_post
    delete "/posts/#{@post.id}"
  end

  def test_show
    get "/posts/#{@post.id}"
  end

  def test_rate_post
    get "/posts/#{@post.id}/rate_post"
  end
end
