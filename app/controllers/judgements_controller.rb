class JudgementsController < ChoicesController
  before_action :set_quiz_question_choice

  def create
    @challenger = @quiz.challengers.find(params[:challenger_id])
    judgement
    if @question.next?(@quiz, @question)
      redirect_to quiz_challenger_question_path(@quiz.id, @challenger.id, @question.next(@quiz))
    else
      redirect_to quiz_challenger_path(@quiz.id, @challenger.id)
    end
  end

  private

  def judgement
    @choice.select_answer_true(@choice)
    @challenger.add_score(@challenger) if @choice.correct_answer?(@choice)
  end
end
