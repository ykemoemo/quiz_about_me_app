class ChoicesController < ApplicationController
  def set_correct_answer
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
    @question.choices.update(correct_answer_params)
    binding.pry
    redirect_to quiz_questions_path(@quiz.id)
  end

  def judgement
    @quiz = Quiz.find(params[:quiz_id])
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @question = @quiz.questions.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
    if @choice.correct_answer == true
      @challenger.score += 1
      @challenger.save!
      flash[:notice] = "正解！！"
      redirect_to quiz_challenger_question_path(@quiz.id, @challenger.id, @question.id)
    else
      flash[:notice] = "ざんねん！"
      redirect_to quiz_challenger_question_path(@quiz.id, @challenger.id, @question.id)
    end
  end

  private

  def correct_answer_params
    params.require(:question).permit(choices_attributes:[:id, :correct_answer])
  end
end
