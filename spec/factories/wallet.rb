FactoryBot.define do
  factory :wallet do
    account_no { Faker::Bank.account_number(digits: 13) }
    entity_id { 1 }
    amount { Faker::Commerce.price }
  end
end