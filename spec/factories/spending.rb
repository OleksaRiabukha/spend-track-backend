require 'faker'


FactoryBot.define do
  factory :spending do
    description { Faker::String.random(length: 4) }
    amount { Faker::Number.number(digits: 4) }
    category_id { association(:category) }
    user_id { association(:user) }
  end
end