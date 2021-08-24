class Quiz < ApplicationRecord
  has_many :questions
  accepts_nested_attributes_for :questions
  has_many :challengers

  validates :creator_name, length: { maximum: 12 }, presence: true
end
