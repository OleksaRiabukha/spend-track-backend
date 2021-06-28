require 'faker'


FactoryBot.define do
  factory :category do
    name { Faker::Lorem.unique }
    # spendings { Spending.first || association(:spending) }
  end
end