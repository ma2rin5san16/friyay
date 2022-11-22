require 'rails_helper'

RSpec.describe Task, type: :model do
  it "content、easy、user_idが入力されている場合、有効である" do
    expect(FactoryBot.build(:task)).to be_valid
  end

  it "contentがない場合、無効である" do
    expect(FactoryBot.build(:task, content: "")).to_not be_valid
  end

  it "easyがない場合、無効である" do
    expect(FactoryBot.build(:task, easy: "")).to_not be_valid
  end

end
