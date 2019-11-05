FactoryBot.define do
  factory :entity do
  	id { 1 }
    name  { Faker::Name.unique.name }
    entity_type { 'User' }
    email { Faker::Internet.email }
    password { "password"} 
    password_confirmation { "password" }
  end
end