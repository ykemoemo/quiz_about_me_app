class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :complete_questions_count, -> { joins(:choices).where(choices: { correct_answer: true }).count }
end
