class QuestionsController < ApplicationController

  before_action :set_quiz

  def index
    @questions = @quiz.questions.all.includes(:quiz)
    @question = Question.new
    @question.choices.build
    if @questions.blank?
      default_questions
    end
  end

  def show
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @question = @quiz.questions.find(params[:id])
    @questions_count = @quiz.questions.all.count
    choices = @question.choices.all
    choices.each do |choice|
      choice.select_answer = false
      choice.save
    end
    if flash.blank?
      @challenger.question_count += 1
      @challenger.save
    end
  end

  def create
    @question = @quiz.questions.new(question_params)
    if @question.save
      @questions = @quiz.questions.all.includes(:quiz)
    else
      @questions = @quiz.questions.all.includes(:quiz)
      render "index"
    end
  end

  def destroy
    question = @quiz.questions.find(params[:id])
    @questions = @quiz.questions.all.includes(:quiz)
    question.destroy!
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:body, choices_attributes:[:id, :body]).merge(quiz_id: params[:quiz_id])
  end

  def default_questions
    question_1 = Question.create!( quiz_id: params[:quiz_id], body: "休みの日は何して過ごす？" )
      question_1.choices.create!([
        { body: "お家でゴロゴロ" },
        { body: "外へおでかけ" },
      ])

    question_2 = Question.create!( quiz_id: params[:quiz_id], body: "高校生の時の部活は？" )
      question_2.choices.create!([
        { body: "運動部" },
        { body: "文化部" },
      ])

    question_3 = Question.create!( quiz_id: params[:quiz_id], body: "どっちが好き？" )
      question_3.choices.create!([
        { body: "おしゃれなレストラン" },
        { body: "大衆居酒屋" },
    ])

    question_4 = Question.create!( quiz_id: params[:quiz_id], body: "どっちをよく使う？" )
      question_4.choices.create!([
        { body: "Twitter" },
        { body: "Instagram" },
    ])

    question_5 = Question.create!( quiz_id: params[:quiz_id], body: "明日世界が滅亡するとしたら？" )
      question_5.choices.create!([
        { body: "家族と過ごす" },
        { body: "好きな人と過ごす" },
    ])

    @questions = [ question_1, question_2, question_3, question_4, question_5 ]
  end
end
 