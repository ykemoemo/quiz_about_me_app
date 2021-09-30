class QuestionsController < ApplicationController
  before_action :set_quiz

  def index
    @questions = @quiz.questions.all.includes(:quiz)
    @question = Question.new
    @question.choices.build
    @questions_count = @questions.count
    @complete_questions_count = @questions.complete_questions_count
    return unless @questions.blank?

    default_questions
    @questions_count = @quiz.questions.all.count
  end

  def show
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @question = @quiz.questions.find(params[:id])
    @questions_count = @quiz.questions.all.count
    choice_reset
    @challenger.question_count += 1
    @challenger.save
  end

  def create
    @question = @quiz.questions.new(question_params)
    if @question.save
      @questions = @quiz.questions.all.includes(:quiz)
      @questions_count = @questions.count
      @complete_questions_count = @questions.complete_questions_count
    else
      render 'index'
    end
  end

  def destroy
    question = @quiz.questions.find(params[:id])
    @questions = @quiz.questions.all.includes(:quiz)
    question.destroy!
    @questions_count = @quiz.questions.all.count
    @complete_questions_count = @questions.complete_questions_count
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:body, choices_attributes: [:id, :body, :_destroy]).merge(quiz_id: params[:quiz_id])
  end

  def choice_reset
    choices = @question.choices.all
    choices.each do |choice|
      choice.select_answer = false
      choice.save
    end
  end

  def default_questions
    question1 = Question.new(quiz_id: params[:quiz_id], body: '休みの日は何して過ごす？')
    question1.choices.new([
                            { body: 'お家でゴロゴロ' },
                            { body: '外へおでかけ' }
                          ])
    question1.save

    question2 = Question.new(quiz_id: params[:quiz_id], body: '高校生の時の部活は？')
    question2.choices.new([
                            { body: '運動部' },
                            { body: '文化部' }
                          ])
    question2.save

    question3 = Question.new(quiz_id: params[:quiz_id], body: 'どっちが好き？')
    question3.choices.new([
                            { body: 'おしゃれなレストラン' },
                            { body: '大衆居酒屋' }
                          ])
    question3.save

    question4 = Question.new(quiz_id: params[:quiz_id], body: 'どっちをよく使う？')
    question4.choices.new([
                            { body: 'Twitter' },
                            { body: 'Instagram' }
                          ])
    question4.save

    question5 = Question.new(quiz_id: params[:quiz_id], body: '明日世界が滅亡するとしたら？')
    question5.choices.new([
                            { body: '家族と過ごす' },
                            { body: '好きな人と過ごす' }
                          ])
    question5.save

    @questions = [question1, question2, question3, question4, question5]
  end
end
