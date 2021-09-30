class Challenger < ApplicationRecord
  belongs_to :quiz

  validates :name, length: { maximum: 12 }, presence: true
  validates :score, numericality: { only_integer: true }

  scope :ranking, -> (count) { order(score: :DESC).limit(count) }
end
