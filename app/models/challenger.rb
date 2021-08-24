class Challenger < ApplicationRecord
  belongs_to :quiz

  validates :name, length: { maximum: 12 }, presence: true
  validates :score, numericality: { only_integer: true }
end
