require 'test_helper'
require 'rails/performance_test_help'
 
include SessionsHelper

class QuestionsControllerPerfomanceTest < ActionDispatch::PerformanceTest

    def setup
        @user = users(:admin)
        @question = questions(:question_01)
    end

    def test_index
        get '/questions'
    end

    def test_updating_question
        patch "/questions/#{@question.id}", params: {
            year: 2011
        }
    end

    def test_edit
        get "/questions/#{@question.id}/edit"
    end

    def test_show
        get "/questions/#{@question.id}"
    end

    def test_delete_question
        delete "/questions/#{@question.id}"
    end

    def test_answer_question
        post "/questions/#{@question.id}/answer", alternative: @question.right_answer.next
    end

end
