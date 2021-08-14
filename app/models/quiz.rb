class Quiz < ApplicationRecord
  has_many :questions
  accepts_nested_attributes_for :questions
  has_many :challengers
end
