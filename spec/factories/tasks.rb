FactoryBot.define do
  factory :task do
    content { "予定案の内容" }
    easy { "easy" }
    user_id { user1 = FactoryBot.create(:user).id }
  end
end
