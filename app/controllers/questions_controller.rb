class QuestionsController < ApplicationController
  before_action :set_quiz_questions
  before_action :set_questions_count, expect: [:destroy]
  before_action :set_complete_questions_count, expect: [:show, :destroy]

  def index
    redirect_to root_path if quiz_already_created?
    @question = Question.new
    @question.choices.build
    return if @questions.present?

    set_default_questions
  end

  def show
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @question = @quiz.questions.find(params[:id])
    reset_select_answer
  end

  def create
    @question = @quiz.questions.new(question_params)
    return if @question.save

    render 'index'
  end

  def destroy
    question = @quiz.questions.find(params[:id])
    question.destroy!
    set_questions_count
    set_complete_questions_count
  end

  private

  def set_quiz_questions
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions.all.includes(:quiz)
  end

  def question_params
    params.require(:question).permit(:body, choices_attributes: [:id, :body, :_destroy]).merge(quiz_id: params[:quiz_id])
  end

  def set_default_questions
    @questions = @quiz.questions.default_questions(@quiz)
    @questions_count = @quiz.questions.all.count
  end

  def set_questions_count
    @questions_count = @questions.count
  end

  def set_complete_questions_count
    @complete_questions_count = @questions.complete_questions_count
  end

  def reset_select_answer
    choices = @question.choices.all
    choices.select_answers_false(choices)
    @challenger.add_question_count(@challenger)
  end

  def quiz_already_created?
    @questions.present? && @questions_count == @complete_questions_count
  end
end
