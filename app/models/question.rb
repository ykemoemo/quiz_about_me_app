class Question < ApplicationRecord
  has_many :choices
  accepts_nested_attributes_for :choices
  belongs_to :quiz
end
