require 'rails_helper'

RSpec.describe "Tasks" do
  describe '未ログインユーザーの場合' do
    let(:user) { create(:user) }
    let(:task) { create(:task) }

    context 'ログインページへ遷移' do
      it '予定案を新規作成する場合、ログインページへ遷移する' do
        visit root_path
        click_link 'Search'
        expect(page).to have_selector 'div.alert.alert-warning', text: 'ログインが必要です'
        expect(current_path).to eq login_path
      end
      it '予定案一覧を閲覧する場合、ログインページへ遷移する' do
        visit tasks_path
        expect(page).to have_selector 'div.alert.alert-warning', text: 'ログインが必要です'
        expect(current_path).to eq login_path
      end
      it '予定案の編集ページに遷移する' do
        visit edit_task_path(task)
        expect(page).to have_selector 'div.alert.alert-warning', text: 'ログインが必要です'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ユーザー登録した場合' do
    before do
      @user = FactoryBot.create(:user)
      login(@user)
    end
    
    context '各ページにアクセスできる' do
      it '予定案を新規作成することができる' do
        visit root_path
        expect(page).to have_link 'id-suggest', href: '/tasks/new'
        click_on 'id-suggest'
        fill_in 'task[content]', with: 'new_task'
        find('label[for=task_easy_easy]').click
        expect do
          click_button "登録"
        end.to change(Task, :count).by(1)
        expect(page).to have_selector 'div.alert.alert-success', text: '過ごし方を提案しました'
      end

      it '予定案一覧を閲覧することができる' do
        visit root_path
        login(@user)
        visit tasks_path
        expect(current_path).to eq tasks_path
      end

      it '予定案を編集することができる' do
        visit root_path
        login(@user)
        @task = FactoryBot.create(:task, content: 'before_task', user_id: @user.id)
        visit suggested_list_path
        click_on 'edit'
        fill_in 'task[content]', with: 'after_task'
        click_button "登録"
        expect(page).to have_content 'after_task'
        expect(page).to have_selector 'div.alert.alert-success', text: '更新しました'
      end

      it '他ユーザーが作成したtaskを編集しようとするとroot_pathに遷移'do
        @another = FactoryBot.create(:user)
        @task = FactoryBot.create(:task, content: 'before_task', user_id: @another.id)
        login(@user)
        visit edit_task_path(@another.id)
        expect(current_path).to eq root_path
      end

      it '予定案を削除することができる' do
        visit root_path
        login(@user)
        @task = FactoryBot.create(:task, user_id: @user.id)
        visit suggested_list_path
        page.accept_confirm do
          click_link "delete"
        end
        expect(page).to have_selector 'div.alert.alert-success', text: '削除しました。'
        expect(Task.count).to eq 0
      end

      it '他人の投稿は削除できない' do
        @another = FactoryBot.create(:user)
        @task = FactoryBot.create(:task, content: 'before_task', user_id: @another.id)
        login(@user)
        delete task_path(@another.id)
        expect(current_path).to eq root_path
      end
    end
  end
end
