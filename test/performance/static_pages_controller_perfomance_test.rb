require 'test_helper'
require 'rails/performance_test_help'
 
include SessionsHelper

class StaticPagePerfomanceTest < ActionDispatch::PerformanceTest

	def test_help
		get '/help'
	end

	def test_about
		get '/about'
	end

	def test_home
		get '/'
	end

end
