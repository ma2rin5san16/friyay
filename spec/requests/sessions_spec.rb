require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /login" do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status :success
    end
  end

  describe '#create' do
    context '無効な値の場合' do
      it 'flashメッセージが表示される' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_selector 'div.alert.alert-danger'
      end
    end

    context '有効な値の場合' do
      let(:user) { FactoryBot.create(:user) }

      it 'トップページに遷移し、フラッシュメッセージが表示される' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        expect(current_path).to eq root_path
        expect(page).to have_selector 'div.alert.alert-success'
      end
    end
  end

  describe '#destroy' do
    let(:user) { FactoryBot.create(:user) }
    
    it "ログアウト後、トップページが表示され、フラッシュメッセージが表示される" do
      login(user)
      delete logout_path
      expect(current_path).to eq root_path
      expect(page).to have_selector 'div.alert.alert-success'
      expect(session[:user_id]).to eq nil
    end
  end
end
