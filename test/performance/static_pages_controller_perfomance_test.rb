require 'test_helper'
require 'rails/performance_test_help'
 
include SessionsHelper

class StaticPagePerfomanceTest < ActionDispatch::PerformanceTest

	def setup
		get '/login'
		@user = users(:renata)
	end

	def test_help
		log_in @user
		get '/help'
	end

	def test_about
		log_in @user
		get '/about'
	end

	def test_home
    log_in @user
		get '/'
	end

end
