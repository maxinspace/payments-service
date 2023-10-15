FactoryBot.define do
  factory :transaction do
    uuid { "" }
    amount { "9.99" }
    status { :authorized }
    customer_email { "MyString" }
    customer_phone { "MyString" }
    merchant { nil }
  end
end
