require 'test_helper'
require 'rails/performance_test_help'
 
include SessionsHelper

class UsersPerfomanceTest < ActionDispatch::PerformanceTest

	def setup
		@user = users(:admin)
	end

	def test_index
        get '/users'
    end

	def test_create
		post '/users', user: { nickname: 'newuser', name: 'New User', email: 'newuser@email.com', password: '12345678', password_confirmation: '12345678' }
	end

	def test_edit
		get "/users/#{@user.id}/edit"
	end

    def test_show
        get "/users/#{@user.id}"
    end

    def test_delete
        delete "/users/#{@user.id}"
    end

end