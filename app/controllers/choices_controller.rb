class ChoicesController < ApplicationController
  private

  def set_quiz_question_choice
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
    @choice = @question.choices.find(params[:choice_id])
  end
end
