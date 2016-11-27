require 'test_helper'
require 'rails/performance_test_help'

include SessionsHelper

class CommentControllerPerfomanceTest < ActionDispatch::PerformanceTest
  def setup
    @post = posts(:post01)
    @comment = comments(:first)
  end

  def test_new_comment
    get "/posts/#{@post.id}/comments/new"
  end

  def test_create_comment
    post "/posts/#{@post.id}/comments"
  end

  def test_edit_comment
    get "/posts/#{@post.id}/comments/#{@comment.id}/edit"
  end

  def test_update_comment
    patch "/posts/#{@post.id}/comments/#{@comment.id}", content: "Modified comment"
  end

  def test_delete_comment
    delete "/posts/#{@post.id}/comments/#{@comment.id}"
  end

  def test_show
    get "/posts/#{@post.id}/comments/#{@comment.id}"
  end

  def test_rate_comment
    get "/comments/#{@comment.id}/rate_comment"
  end
end
