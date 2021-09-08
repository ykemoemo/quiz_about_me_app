FactoryBot.define do
  factory :question do
    sequence(:body, "question_1")
    association :quiz
  end
end
