FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    description { "MyString" }
    email { Faker::Internet.email }
    status { :active }
    total_transaction_sum { 0.00 }
  end
end
