require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task)
    @guest_user = FactoryBot.create(:user, guest: true)
  end

  context '登録済ユーザーがお気に入り登録をする' do
    it 'お気に入り登録することができる' do
      visit root_path
      login(@user)
      expect(page).to have_link 'id-index', href: '/tasks'
      click_link('id-index')
      click_on("js-favorite-button-for-task-#{@task.id}")
      expect(page).to have_content 'お気に入り解除'
    end

    it 'お気に入り登録済の投稿を評価することができる' do
      @favorite = FactoryBot.create(:favorite, task_id: @task.id, user_id: @user.id )
      visit root_path
      login(@user)
      expect(page).to have_link 'id-favorited-list', href: '/favorited_list'
      click_link('id-favorited-list')
      click_link('未実行')
      expect(page).to have_selector 'div.alert.alert-success', text: 'ステータスを更新しました'
      expect(page).to have_content '実行済'
      click_link('評価する')
      fill_in 'favorite[comment]', with: 'コメントです'
      click_button('評価する')
      expect(page).to have_selector 'div.alert.alert-success', text: '評価しました'
      expect(page).to have_content 'コメントです'
    end
    it 'お気に入り解除することができる' do
      @favorite = FactoryBot.create(:favorite, task_id: @task.id, user_id: @user.id )
      login(@user)
      visit tasks_path
      expect(page).to have_content 'お気に入り解除'
      page.accept_confirm do
        click_on("js-favorite-button-for-task-#{@task.id}")
      end
      expect(page).to have_content '気になる'
    end
  end

  context 'ゲストユーザーがお気に入り登録をする' do
    it 'お気に入り登録することができる' do
      visit root_path
      login(@guest_user)
      expect(page).to have_link 'id-index', href: '/tasks'
      click_link('id-index')
      click_on("js-favorite-button-for-task-#{@task.id}")
      expect(page).to have_content 'お気に入り解除'
    end

    it 'お気に入り登録済の投稿を評価することができない' do
      @favorite = FactoryBot.create(:favorite, task_id: @task.id, user_id: @guest_user.id )
      visit root_path
      login(@guest_user)
      expect(page).to have_link 'id-favorited-list', href: '/favorited_list'
      click_link('id-favorited-list')
      click_link('未実行')
      expect(page).to have_selector 'div.alert.alert-warning', text: 'ユーザー登録が必要な機能です'
      expect(current_path).to eq new_user_path
    end
    it 'お気に入り解除することができる' do
      @favorite = FactoryBot.create(:favorite, task_id: @task.id, user_id: @guest_user.id )
      login(@guest_user)
      visit tasks_path
      expect(page).to have_content 'お気に入り解除'
      page.accept_confirm do
        click_on("js-favorite-button-for-task-#{@task.id}")
      end
      expect(page).to have_content '気になる'
    end
  end
end
