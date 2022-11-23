FactoryBot.define do
  factory :task do
    content { "予定案の内容" }
    easy { "easy" }
    association :user
  end
end
