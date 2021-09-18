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
    if choice.correct_answer == true
      challenger.score += 1
      challenger.save
      flash[:notice] = "正解！！"
      redirect_to quiz_challenger_question_path(@quiz.id, challenger.id, @question.id)
    else
      flash[:notice] = "ざんねん！"
      redirect_to quiz_challenger_question_path(@quiz.id, challenger.id, @question.id)
    end
  end

  private

  def set_question
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
  end

  def correct_answer_params
    params.require(:question).permit(choices_attributes:[:id, :correct_answer])
  end
end
