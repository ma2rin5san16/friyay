FactoryBot.define do
  factory :favorite do
    user_id { FactoryBot.create(:user).id }
    task_id { FactoryBot.create(:task).id }
  end
end
