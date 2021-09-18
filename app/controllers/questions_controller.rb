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
    question_1 = Question.create!( quiz_id: params[:quiz_id], body: "どっち派？" )
      question_1.choices.create!([
        { body: "きのこの山" },
        { body: "たけのこの里" },
    ])

    question_2 = Question.create!( quiz_id: params[:quiz_id], body: "たい焼きはどこから食べる？" )
      question_2.choices.create!([
        { body: "頭" },
        { body: "尻尾" },
      ])

    question_3 = Question.create!( quiz_id: params[:quiz_id], body: "結婚するなら？" )
      question_3.choices.create!([
        { body: "お金持ちのブサイク" },
        { body: "貧乏だけどルックスは最高" },
      ])
    question_4 = Question.create!( quiz_id: params[:quiz_id], body: "どっちになりたい？" )
      question_4.choices.create!([
        { body: "嫌われ者の大金持ち" },
        { body: "みんなから愛される貧乏人" },
      ])

    question_5 = Question.create!( quiz_id: params[:quiz_id], body: "住むならどっち？" )
      question_5.choices.create!([
        { body: "幽霊が出る家" },
        { body: "ゴキブリだらけの家" },
    ])

    question_6 = Question.create!( quiz_id: params[:quiz_id], body: "食べるならどっち？" )
      question_6.choices.create!([
        { body: "ウ○コ味のカレー" },
        { body: "カレー味のウ◯コ" },
    ])

    question_7 = Question.create!( quiz_id: params[:quiz_id], body: "どっちの世界がいい？" )
      question_7.choices.create!([
        { body: "一年中真夏" },
        { body: "一年中真冬" },
    ])

    question_8 = Question.create!( quiz_id: params[:quiz_id], body: "どっちを選ぶ？" )
      question_8.choices.create!([
        { body: "1000万円を確実にもらえる" },
        { body: "2分の1の確率で1億円をもらえる" },
    ])

    question_9 = Question.create!( quiz_id: params[:quiz_id], body: "どっちが欲しい？" )
      question_9.choices.create!([
        { body: "未来にタイムリープできる能力" },
        { body: "過去にタイムスリップできる能力" },
    ])

    question_10 = Question.create!( quiz_id: params[:quiz_id], body: "歌うとしたら？" )
      question_10.choices.create!([
        { body: "マイクのないカラオケ" },
        { body: "サビ前で終わるカラオケ" },
    ])

    @questions = [ question_1, question_2, question_3, question_4, question_5, question_6, question_7, question_8, question_9, question_10 ]
  end
end
 