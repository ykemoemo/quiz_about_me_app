class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions
  has_many :challengers, dependent: :destroy

  validates :creator_name, length: { maximum: 12 }, presence: true
end
