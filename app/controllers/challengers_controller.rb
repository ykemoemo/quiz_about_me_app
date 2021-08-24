class ChallengersController < ApplicationController

  before_action :set_quiz

  def show
    @challenger = @quiz.challengers.find(params[:id])
    @questions_count = @quiz.questions.count
    @challengers_ranking = @quiz.challengers.order(score: :DESC)
  end

  def new
    @challenger = Challenger.new
  end

  def create
    @question = @quiz.questions.first
    @challenger = @quiz.challengers.new(challenger_params)
    if @challenger.save
      redirect_to quiz_challenger_question_path(@quiz, @challenger, @question)
    else
      render 'new'
    end
  end

  def update
    @challenger = @quiz.challengers.find(params[:id])
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def challenger_params
    params.require(:challenger).permit(:name ).merge(quiz_id: params[:quiz_id])
  end
end
