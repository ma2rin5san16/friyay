require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @guest_user = FactoryBot.create(:user, guest: true)
  end

  context 'プロフィール' do
    it 'ログインユーザーのプロフィールを表示することができる' do
      visit root_path
      login(@user)
      find('button.navbar-toggler').click
      click_link('マイページ')
      expect(page).to have_content "#{@user.name}"
    end
    it 'ログインユーザーのプロフィールを編集することができる' do
      login(@user)
      visit profile_path
      click_link('edit')
      fill_in 'user[name]', with: 'new_name'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button('登録する')
      expect(page).to have_selector 'div.alert.alert-success', text: '登録内容を編集しました'
      expect(page).to have_content 'new_name'
    end
    it 'ゲストユーザーはプロフィールを編集のリンクが表示されない' do
      login(@guest_user)
      visit profile_path
      expect(page).not_to have_link 'edit'
    end
    it 'ゲストユーザーがプロフィールを編集しようとするとユーザー登録ページに移る' do
      login(@guest_user)
      visit edit_profile_path
      expect(page).to have_selector 'div.alert.alert-warning', text: 'ユーザー登録が必要な機能です'
      expect(current_path).to eq new_user_path
    end
  end
end
