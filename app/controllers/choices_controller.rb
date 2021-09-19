class ChoicesController < ApplicationController

  before_action :set_quiz_question_choice

  def set_correct_answer
    choices = @question.choices.all
    choices.each do |choice|
      choice.correct_answer = false
      choice.save
    end
    @choice.correct_answer = true
    @choice.save
    @questions = @quiz.questions.all.includes(:quiz)
  end

  def judgement
    challenger = @quiz.challengers.find(params[:challenger_id])
    @choice.select_answer = true
    @choice.save
    if @choice.correct_answer == true
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

  def set_quiz_question_choice
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
  end
end
