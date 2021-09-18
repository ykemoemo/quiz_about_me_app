class ChoicesController < ApplicationController

  before_action :set_question

  def set_correct_answer
    choice = @question.choices.find(params[:id])
    if choice.correct_answer == true
      choice.correct_answer = false
    else
      choice.correct_answer = true
    end
    choice.save
    @questions = @quiz.questions.all.includes(:quiz)
  end

  def judgement
    challenger = @quiz.challengers.find(params[:challenger_id])
    choice = @question.choices.find(params[:id])
    choice.select_answer = true
    choice.save
    if choice.correct_answer == true
      challenger.score += 1
      challenger.save
    end
    if @question.next(@quiz).present?
      redirect_to quiz_challenger_question_path(@quiz.id, challenger.id, @question.next(@quiz))
    else
      redirect_to quiz_challenger_path(@quiz.id, challenger.id)
    end
  end

  private

  def set_question
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
  end
end
