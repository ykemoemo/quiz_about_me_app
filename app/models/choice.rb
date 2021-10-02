class Choice < ApplicationRecord
  belongs_to :question

  validates :body, length: { maximum: 24 }, presence: true
  validates :correct_answer, inclusion: { in: [true, false] }

  def correct_answer?(choice)
    choice.correct_answer == true
  end

  def correct_answer_true(choice)
    choice.update(correct_answer: true)
  end

  def self.correct_answers_false(choices)
    choices.update_all(correct_answer: false)
  end

  def select_answer_true(choice)
    choice.update(select_answer: true)
  end

  def self.select_answers_false(choices)
    choices.update_all(select_answer: false)
  end
end
