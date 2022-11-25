require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    @user = FactoryBot.build(:user)
  end

  describe "GET /new" do
    context 'ユーザーが新規登録できる' do
      it '正しい入力をすると新規登録ができ、ログインページへ遷移する' do
        visit root_path
        expect(page).to have_content('LOGIN / SIGN UP')
        visit login_path
        expect(page).to have_content('新規ユーザー登録はこちら')
        visit new_user_path

        fill_in 'user[name]', with: @user.name
        fill_in 'user[email]', with: @user.email
        select '1990',from: 'user[birthday(1i)]'
        choose 'user_gender_male'
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password_confirmation

      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect do
          click_button "登録する"
        end.to change(User, :count).by(1)

        # トップページへ遷移したことを確認する
        expect(current_path).to eq root_path
        expect(page).to have_selector 'div.alert.alert-success', text: 'ユーザーを登録しました'
      end
    end

    context 'ユーザー新規登録ができないとき' do
      it '誤った情報の場合、新規登録ができずに新規登録ページに戻ってくる' do
        visit new_user_path
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        select '--',from: 'user[birthday(1i)]'
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''

        # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
        expect do
          click_button "登録する"
        end.to change(User, :count).by(0)

        # 画面遷移せず、エラーメッセージが表示される
        expect(current_path).to eq "/users"
        expect(page).to have_content '登録に失敗しました'
      end
    end
  end
end
