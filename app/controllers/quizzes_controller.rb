class QuizzesController < ApplicationController
  def index
  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = @quiz.questions.all.includes(:quiz)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to quiz_questions_path(@quiz.id)
    else
      render 'new'
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:creator_name)
  end

  def question_params
    params.require(:question).permit(:body, choices_attributes:[:id, :body, :correct_answer]).merge(quiz_id: params[:quiz_id])
  end
end
