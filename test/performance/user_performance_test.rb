require 'test_helper'
require 'rails/performance_test_help'

class MedalModelTest < ActionDispatch::PerformanceTest
  def setup
    @user = users(:renata)
  end

  def test_creation_user
    User.create name: "Renata Soares", email: "renatasoares@gmail.com",
                password: "renatagata", level: 0, nickname: "renatasoares",
                role_admin: false, points: 0
  end

  def test_count_questions_by_area
    @user.count_questions_by_area("matemática e suas tecnologias")
  end

  def test_find_position_in_ranking
    @user.find_position_in_ranking
  end

  def test_total_accepted_questions
    @user.total_accepted_questions
  end

  def test_data
    @user.data
  end

  def test_sum_exam_performance
    @user.sum_exam_performance
  end

  def test_progress
    @user.progress
  end

  def test_battles
    @user.battles
  end

  def test_average_performance
    @user.average_performance "matemática e suas tecnologias"
  end

  def test_classification
    @user.classification "matemática e suas tecnologias"
  end
end
