class Choice < ApplicationRecord
  belongs_to :question

  validates :body, length: { maximum: 24 }, presence: true
  validates :correct_answer, inclusion: { in: [true, false] }
end
