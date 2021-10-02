class ChallengersController < ApplicationController
  before_action :set_quiz

  def show
    @challenger = @quiz.challengers.find(params[:id])
    @questions = @quiz.questions.all
    @questions_count = @quiz.questions.count
    @challengers_ranking = @quiz.challengers.ranking(10)
  end

  def new
    @challenger = Challenger.new
    @challengers_ranking = @quiz.challengers.ranking(5)
  end

  def create
    @challenger = @quiz.challengers.new(challenger_params)
    if @challenger.save
      question = @quiz.questions.first
      redirect_to quiz_challenger_question_path(@quiz, @challenger, question)
    else
      @challengers_ranking = @quiz.challengers.ranking(5)
      render 'new'
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def challenger_params
    params.require(:challenger).permit(:name).merge(quiz_id: params[:quiz_id])
  end
end
