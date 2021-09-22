class Question < ApplicationRecord
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
  belongs_to :quiz

  validates :body, length: { maximum: 22 }, presence: true
  validates :choices, :presence => true

  def next(quiz)
    quiz.questions.where("id > ?", self.id).order("id ASC").first
  end
end
