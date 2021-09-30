FactoryBot.define do
  factory :challenger do
    sequence(:name, 'challenger_1')
    score { 10 }
    association :quiz
  end
end
