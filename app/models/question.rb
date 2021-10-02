class Question < ApplicationRecord
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  belongs_to :quiz

  validates :body, length: { maximum: 22 }, presence: true
  validates :choices, presence: true

  def next(quiz)
    quiz.questions.where('id > ?', id).order('id ASC').first
  end

  def next?(quiz, question)
    question.next(quiz).present?
  end

  def self.default_questions(quiz)
    question1 = quiz.questions.create(body: '休みの日は何して過ごす？', choices_attributes: [{ body: 'お家でゴロゴロ' }, { body: '外へおでかけ' }])

    question2 = quiz.questions.create(body: '高校生の時の部活は？', choices_attributes: [{ body: '運動部' }, { body: '文化部' }])

    question3 = quiz.questions.create(body: 'どっちが好き？', choices_attributes: [{ body: 'おしゃれなレストラン' }, { body: '大衆居酒屋' }])

    question4 = quiz.questions.create(body: 'どっちをよく使う？', choices_attributes: [{ body: 'Twitter' }, { body: 'Instagram' }])

    question5 = quiz.questions.create(body: '明日世界が滅亡するとしたら？', choices_attributes: [{ body: '家族と過ごす' }, { body: '好きな人と過ごす' }])

    [question1, question2, question3, question4, question5]
  end
end
