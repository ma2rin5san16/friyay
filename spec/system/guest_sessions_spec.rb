require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe '#create' do
    context '無効な値の場合' do
      it 'flashメッセージが表示される' do
        visit root_path
        expect(page).to have_content('LOGIN as GUEST')
        visit guest_sessions_new_path
        select '--',from: '[birthday(1i)]'
        expect do
            click_button "ログイン"
          end.to change(User, :count).by(0)
        expect(page).to have_selector 'div.alert.alert-danger', text: 'ログインできませんでした'
        expect(current_path).to eq "/guest_login"
      end
    end

    context '有効な値の場合' do
      it 'トップページに遷移し、フラッシュメッセージが表示される' do
        visit root_path
        expect(page).to have_content('LOGIN as GUEST')
        visit guest_sessions_new_path
        select '1990',from: '[birthday(1i)]'
        choose 'gender_male'
        expect do
            click_button "ログイン"
          end.to change(User, :count).by(1)
        expect(page).to have_selector 'div.alert.alert-success', text: 'ゲストとしてログインしました'
        expect(current_path).to eq root_path
      end
    end
  end
end
