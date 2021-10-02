class Challenger < ApplicationRecord
  belongs_to :quiz

  validates :name, length: { maximum: 12 }, presence: true
  validates :score, numericality: { only_integer: true }

  scope :ranking, ->(count) { order(score: :DESC).limit(count) }

  def add_score(challenger)
    challenger.increment!(:score, 1)
  end

  def add_question_count(challenger)
    challenger.increment!(:question_count, 1)
  end
end
