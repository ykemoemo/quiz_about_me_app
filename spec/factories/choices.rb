FactoryBot.define do
  factory :choice do
    sequence(:body, 'choice_1')
    correct_answer { true }
    association :question
  end
end
