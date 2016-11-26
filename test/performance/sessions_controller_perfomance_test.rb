require 'test_helper'
require 'rails/performance_test_help'
 
class SessionsControllerṔerfomanceTest < ActionDispatch::PerformanceTest

	def setup
		@user = users(:admin)
	end

  def test_new_session
		get '/login'
  end

end