class ChoicesController < ApplicationController
  before_action :set_quiz_question_choice

  def set_correct_answer
    choices = @question.choices.all
    choices.correct_answers_false(choices)
    @choice.correct_answer_true(@choice)
    @questions = @quiz.questions.all.includes(:quiz)
    @questions_count = @questions.count
    @complete_questions_count = @questions.complete_questions_count
  end

  def judgement
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @choice.select_answer_true(@choice)
    @challenger.add_score(@challenger) if @choice.correct_answer?(@choice)
    if @question.next?(@quiz, @question)
      redirect_to quiz_challenger_question_path(@quiz.id, @challenger.id, @question.next(@quiz))
    else
      redirect_to quiz_challenger_path(@quiz.id, @challenger.id)
    end
  end

  private

  def set_quiz_question_choice
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.find(params[:question_id])
    @choice = @question.choices.find(params[:id])
  end
end
