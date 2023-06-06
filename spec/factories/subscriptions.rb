FactoryBot.define do 
  factory :subscription do 
    title {Faker::Lorem.word}
    status {Faker::Emotion.adjective}
    frequency {"#{rand(1..3)} per month"}
    price {"$#{rand(3..10)}"}
  end
end