require 'test_helper'
require 'rails/performance_test_help'

include SessionsHelper

class ExamsControllerPerfomanceTest < ActionDispatch::PerformanceTest
  def test_select_exam
    get '/select_exam'
  end

  def test_exam_statistics
    get '/exams_statistics'
  end

  def test_answer_exam
    get '/answer_exam'
  end

  def test_exam_result
    get '/exam_result'
  end

  def test_cancel_exam
    delete '/cancel_exam'
  end
end
