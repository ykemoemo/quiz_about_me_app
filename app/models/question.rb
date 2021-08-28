class Question < ApplicationRecord
  has_many :choices
  accepts_nested_attributes_for :choices
  belongs_to :quiz

  validates :body, length: { maximum: 22 }, presence: true

  def next(quiz)
    quiz.questions.where("id > ?", self.id).order("id ASC").first
  end
end
