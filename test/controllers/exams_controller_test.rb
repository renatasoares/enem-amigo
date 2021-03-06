require 'test_helper'
include SessionsHelper

class ExamsControllerTest < ActionController::TestCase

  def setup
    @request.env['HTTP_REFERER'] = 'http://test.host/#'
    @user = users(:renata)
    @math_question = create_question(2011,"matemática e suas tecnologias",22)
    @human_question = create_question(2014,"ciências humanas e suas tecnologias",23)
    @language_question = create_question(2011,"linguagens, códigos e suas tecnologias",24)
    @nature_question = create_question(2014,"ciências da natureza e suas tecnologias",25)
  end

  test "should get select_exam page when user is logged in" do
    log_in @user
    get :select_exam
    assert_response :success
  end

  test "should not get select_exam page when user is logged in" do
    get :select_exam
    assert_redirected_to login_path
  end

  test "should not get answer_exam page if user is not logged in" do
    get :answer_exam
    assert_redirected_to login_path
  end

  test "should get answer_exam page if there are questions in the database" do
    log_in @user
    get :answer_exam
    assert_response :success
  end

  test "should not get answer_exam page if there are no questions in the database" do
    log_in @user
    Question.destroy_all
    get :answer_exam
    assert_redirected_to :back
  end

  test "should exam have the same number of questions and right_answers when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_equal last_exam.questions.count, last_exam.right_answers.count
  end

  test "should create exam when user clicks goes to answer_exam page" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam
    assert_not_equal old_exam, Exam.last
  end

  test "should create year exam if there are question for that year" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam, year_exam: 2011
    new_exam = Exam.last
    assert_not_equal old_exam, new_exam
  end

  test "should not create year exam if there are no question for that year" do
    log_in @user
    old_exam = Exam.last
    get :answer_exam, year_exam: 2019
    new_exam = Exam.last
    assert_equal old_exam, new_exam
    assert_redirected_to :back
  end

  test "should right_answers not be empty when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_not last_exam.right_answers.empty?
  end

  test "should questions not be empty when an exam is created" do
    log_in @user
    get :answer_exam
    last_exam = Exam.last
    assert_not last_exam.questions.empty?
  end

  test "should user be redirected to exam_result when he submits an exam" do
    log_in @user
    get :answer_exam
    post :answer_exam, exam_id: 58, alternative_12: "a"
    assert_response :success
  end

  test "should user cannot access exam_result page if he did not answer an exam" do
    log_in @user
    get :exam_result
    assert_redirected_to :back
  end

  test "should user can access exam_result page if he answers an exam" do
    log_in @user
    get :answer_exam
    get :exam_result, exam_id: Exam.last.id
    assert_response :success
  end

  test "should delete exam if user cancels it" do
    log_in @user
    get :answer_exam
    old_count = Exam.all.count
    id = Exam.last.id
    delete :cancel_exam, exam_id: id
    new_count = Exam.all.count
    assert_equal old_count-1, new_count
  end

  test "should exam_result collects user answers when user answers an exam" do
    log_in @user
    get :answer_exam
    question = Question.find(Exam.last.questions.first)
    get :exam_result, exam_id: Exam.last.id, "alternative_#{question.id}": "b"
    assert_not Exam.last.user_answers.empty?
  end

  test "should exam_result not collect user answers if user does not answer an exam" do
    log_in @user
    get :answer_exam
    assert Exam.last.user_answers.empty?
  end

  test "should accepted_answers increments when user answers question right" do
    log_in @user
    get :answer_exam
    question = Question.find(Exam.last.questions.first)
    get :exam_result, exam_id: Exam.last.id, "alternative_#{question.id}": "#{question.right_answer}"
    assert_not_equal Exam.last.accepted_answers, 0
  end

  test "should accepted_answers not increment when user does not answer question right" do
    log_in @user
    get :answer_exam
    question = Question.find(Exam.last.questions.first)
    get :exam_result, exam_id: Exam.last.id, "alternative_#{question.id}": "#{question.right_answer.next}"
    assert_equal Exam.last.accepted_answers, 0
  end

  test "should exams_total_questions in user be incremented if user answers an exam" do
    log_in @user
    get :answer_exam
    old_exams_total_questions = current_user.exams_total_questions
    get :exam_result, exam_id: Exam.last.id
    current_user.reload
    assert_not_equal old_exams_total_questions, current_user.exams_total_questions
  end

  test "should exams_total_questions in user not be incremented if user does not answer an exam" do
    log_in @user
    old_exams_total_questions = current_user.exams_total_questions
    current_user.reload
    assert_equal old_exams_total_questions, current_user.exams_total_questions
  end

  test "should exam_performance in user be incremented if user answers an exam" do
    log_in @user
    get :answer_exam
    old_exam_perfomance_count = current_user.exam_performance.count
    get :exam_result, exam_id: Exam.last.id
    current_user.reload
    assert_not_equal old_exam_perfomance_count, current_user.exam_performance.count
  end

  test "should exam_performance in user not be incremented if user does not answer an exam" do
    log_in @user
    old_exam_perfomance_count = current_user.exam_performance.count
    current_user.reload
    assert_equal old_exam_perfomance_count, current_user.exam_performance.count
  end

  test "should sum_exam_performance changes if user answers an exam and accepts one answer" do
    log_in @user
    get :answer_exam
    old_sum_exam_performance = current_user.sum_exam_performance
    question = Question.find(Exam.last.questions.first)
    get :exam_result, exam_id: Exam.last.id, "alternative_#{question.id}": "#{question.right_answer}"
    current_user.reload
    assert_not_equal old_sum_exam_performance, current_user.sum_exam_performance
  end

  test "should sum_exam_performance not change if user answers an exam and accepts no answer" do
    log_in @user
    get :answer_exam
    old_sum_exam_performance = current_user.sum_exam_performance
    get :exam_result, exam_id: Exam.last.id
    current_user.reload
    assert_equal old_sum_exam_performance, current_user.sum_exam_performance
  end

  test "should exam not have more than 90 questions" do
    log_in @user
    30.times do |i|
      create_question(2011,"matemática e suas tecnologias",i+50)
      create_question(2014,"ciências humanas e suas tecnologias",i+300)
      create_question(2014,"ciências da natureza e suas tecnologias",i+250)
      create_question(2011,"linguagens, códigos e suas tecnologias",i+900)
    end
    get :answer_exam
    assert_equal Exam.last.questions.count, 90
  end

  test "should exam.questions contains ids for questions in the database" do
    log_in @user
    get :answer_exam
    exam = Exam.last
    exam.questions.each do |a|
      assert_not_nil Question.find(a)
    end
  end

  test "should year exam contains only questions for that year" do
    log_in @user
    year = 2011
    get :answer_exam, year_exam: year
    exam = Exam.last
    exam.questions.each do |a|
      question = Question.find(a)
      assert_equal question.year, year
    end
  end

  test "should year exam not contains questions for another year" do
    log_in @user
    year = 2011
    another_year = 2019
    get :answer_exam, year_exam: year
    exam = Exam.last
    exam.questions.each do |a|
      question = Question.find(a)
      assert_not_equal question.year, another_year
    end
  end

  private
    def create_question year, area, number
      @question = Question.new(area: area, enunciation: 'something', number: number, year: year, right_answer: 'a', image: "", reference: "")
      5.times{@question.alternatives.build}
      @question.alternatives.each do |a|
        a.letter = 'a'
        a.description = 'something'
      end
      @question.save
      @question
    end

end
