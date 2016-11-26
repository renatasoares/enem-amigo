require 'test_helper'
require 'rails/performance_test_help'

class MedalModelTest < ActionDispatch::PerformanceTest
  def setup
    @question = questions(:question_01)
  end

  def test_creation_question
    Question.create area: "matemática e suas tecnologias", enunciation: "something",
                    number: 1, year: 2007, right_answer: 'a'
  end

  def test_hit_rate
    @question.hit_rate
  end

  def test_next_question
    @question.next_question
  end

  def test_users_hit_rate
    @question.users_hit_rate
  end

  def test_total_hit_rate
    @question.total_hit_rate
  end

  def test_data
    @question.data
  end
end
