FactoryBot.define do
  factory :transaction do
    uuid { "" }
    amount { "9.99" }
    status { :authorized }
    customer_email { "MyString" }
    customer_phone { "MyString" }
    merchant { create(:merchant) }

    trait :authorized do
      status { :authorized }
      type { 'Transactions::Authorized' }
    end

    trait :charged do
      status { :charged }
      type { 'Transactions::Charged' }
    end

    trait :reversed do
      status { :reversed }
      type { 'Transactions::Reversed' }
    end

    trait :refunded do
      status { :refunded }
      type { 'Transactions::Refunded' }
    end

    trait :error do
      status { :error }
      type { 'Transactions::Error' }
    end
  end
end
