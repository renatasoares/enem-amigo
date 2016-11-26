require 'test_helper'
require 'rails/performance_test_help'
 
include SessionsHelper

class BattlesControllerPerfomanceTest < ActionDispatch::PerformanceTest

    def setup
        @user = users(:admin)
        @battle = battles(:first_battle)
    end

    def test_index
        get '/battles'
    end

    def test_show
        get "/battles/#{@battle.id}"
    end

    def test_creating_battle
        post "/battles", battle: {category: ""}, player_2_nickname: @user.nickname
    end

    def test_delete_battle
        delete "/battles/#{@battle.id}"
    end

end
