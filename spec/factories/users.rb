FactoryBot.define do
  factory :user do
      name { "テストユーザー" }
      sequence(:email) { |n| "testtt#{n}@example.com" }
      gender { "male" }
      birthday { "1990-01-01" }
      password { "password" }
      password_confirmation { "password" }
  end
end