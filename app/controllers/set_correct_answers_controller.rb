class SetCorrectAnswersController < ChoicesController
  before_action :set_quiz_question_choice

  def create
    set_correct_answer
    @questions = @quiz.questions.all.includes(:quiz)
    @questions_count = @questions.count
    @complete_questions_count = @questions.complete_questions_count
  end

  private

  def set_correct_answer
    choices = @question.choices.all
    choices.correct_answers_false(choices)
    @choice.correct_answer_true(@choice)
  end
end
