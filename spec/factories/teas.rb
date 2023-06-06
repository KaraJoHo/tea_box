FactoryBot.define do 
  factory :tea do 
    title {Faker::Tea.variety}
    description {Faker::Lorem.sentence(word_count: 3)}
    brew_time {Faker::Number.number(digits: 1)}
  end
end