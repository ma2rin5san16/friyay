require 'rails_helper'

RSpec.describe Favorite, type: :model do

  it "task_id とuser_idがあれば、有効" do
    expect(FactoryBot.build(:favorite)).to be_valid
  end

  it "task_idとuser_idはユニークである" do
    favorite1 = Favorite.create(user_id: 1, task_id: 1)
    expect(favorite2 = Favorite.create(user_id: 1, task_id: 1)).to_not be_valid
  end

  it "commentは256文字以上の場合、無効" do
    expect(FactoryBot.build(:favorite, status: "evaluated", comment: "a" * 256)).to_not be_valid
  end

  it "statusが未実行(unevaluated)の時、commentとratingは無効" do
    expect(FactoryBot.build(:favorite, status: "unevaluated", comment: "コメントです", rating: 3)).to_not be_valid
  end

  it "raitingが1以下は無効" do
    expect(FactoryBot.build(:favorite, status: "evaluated",rating: 0)).to_not be_valid
  end

  it "raitingが6以上は無効" do
    expect(FactoryBot.build(:favorite, status: "evaluated",rating: 6)).to_not be_valid
  end

  it "raitingが整数以外は無効" do
    expect(FactoryBot.build(:favorite, status: "evaluated",rating: 3.5)).to_not be_valid
  end
end
