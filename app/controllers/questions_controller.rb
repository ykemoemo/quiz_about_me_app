class QuestionsController < ApplicationController

  before_action :set_quiz

  def index
    @questions = @quiz.questions.all.includes(:quiz)
    #if @questions.blank?
      #default_questions
    #end

    @question = Question.new
    @question.choices.build
  end

  def show
    @challenger = @quiz.challengers.find(params[:challenger_id])
    @question = @quiz.questions.find(params[:id])
  end

  def new
  end

  def create
    @question = @quiz.questions.new(question_params)
    if @question.save
      redirect_to quiz_questions_path
    else
      @questions = @quiz.questions.all.includes(:quiz)
      render :index
    end
  end

  def edit
  end

  def update
    @question = @quiz.questions.find(params[:id])
    if @question.update!(correct_answer_params)
      redirect_to quiz_questions_path
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:body, choices_attributes:[:id, :body, :correct_answer]).merge(quiz_id: params[:quiz_id])
  end

  def default_questions
    @question_1 = Question.create!( quiz_id: params[:quiz_id], body: "食べるならどっち？" )
      @question_1.choices.create!([
        { body: "ウンコ味のカレー" },
        { body: "カレー味のウンコ" },
      ])
    @question_2 = Question.create!( quiz_id: params[:quiz_id], body: "たい焼きはどこから食べる？" )
      @question_2.choices.create!([
        { body: "頭" },
        { body: "尻尾" },
      ])
    @question_3 = Question.create!( quiz_id: params[:quiz_id], body: "どっち派？" )
      @question_3.choices.create!([
        { body: "きのこの山" },
        { body: "たけのこの里" },
      ])
    @question_4 = Question.create!( quiz_id: params[:quiz_id], body: "結婚するなら？" )
      @question_4.choices.create!([
        { body: "お金持ちのブサイク" },
        { body: "貧乏だけどルックス最高" },
      ])
    @question_5 = Question.create!( quiz_id: params[:quiz_id], body: "生まれ変わるなら？" )
      @question_5.choices.create!([
        { body: "ルックスはいいけど超低身長" },
        { body: "ブサイクだけどスタイル抜群" },
      ])

    @questions = [ @question_1, @question_2, @question_3, @question_4, @question_5 ]
  end
end
