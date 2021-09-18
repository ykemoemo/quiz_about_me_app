class QuizzesController < ApplicationController
  def index
  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.all.includes(:quiz)
    if @questions.blank?
      redirect_to quiz_questions_path(@quiz.id)
    end
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      render quiz_questions_path(@quiz.id)
    else
      render 'new'
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:creator_name)
  end
end
