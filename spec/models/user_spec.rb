require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前、メールアドレス、性別、誕生日、パスワードがある場合、有効である" do
    expect(FactoryBot.create(:user)).to be_valid
  end

  it "名前がない場合、無効である" do
    expect(FactoryBot.build(:user, name: "")).to_not be_valid
  end

  it "名前が51文字以上の場合、無効である" do
    expect(FactoryBot.build(:user, name: "a" * 51)).to_not be_valid
  end

  it "メールアドレスがない場合、無効である" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid
  end

  it "メールアドレスが255文字以上の場合、無効である" do
    expect(FactoryBot.build(:user, email: "a"*243  + "@example.com")).to_not be_valid
  end

  it "重複したメールアドレスの場合、無効である" do
    user1 = FactoryBot.create(:user, name: "taro", email: "test@example.com")
    expect(FactoryBot.build(:user, name: "jiro", email: user1.email)).to_not be_valid
  end

  it "性別が選択されていない場合、無効である" do
    expect(FactoryBot.build(:user, gender: "")).to_not be_valid
  end

  it "誕生日が選択されていない場合、無効である" do
    expect(FactoryBot.build(:user, birthday: "")).to_not be_valid
  end

  it "パスワードがない場合、無効である" do
    expect(FactoryBot.build(:user, password: "")).to_not be_valid
  end

  it "パスワードが5文字以下の場合、無効である" do
    expect(FactoryBot.build(:user, password: "a" * 5, password_confirmation: "a" * 5)).to_not be_valid
  end

  it "パスワードが暗号化されているか" do
    user1 = FactoryBot.create(:user)
    expect(user1.password_digest).to_not eq "password"
  end

  it "passwordとpassword_confirmationが異なる場合、無効である" do
    expect(FactoryBot.build(:user, password: "password", password_confirmation: "passward")).to_not be_valid
  end
end
