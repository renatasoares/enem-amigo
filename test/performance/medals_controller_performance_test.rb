require 'test_helper'
require 'rails/performance_test_help'
 
class MedalsControllerPerfomanceTest < ActionDispatch::PerformanceTest

    def setup
        @user = users(:admin)
    end

    def test_index
        get '/medals'
    end

end
