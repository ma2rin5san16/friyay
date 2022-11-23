require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "#index" do
    context "未ログインユーザーの場合" do
      it "レスポンスステータスが302であることを確認後、ログインページに遷移" do
        get tasks_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "ログインユーザーの場合" do
      let(:user) { create(:user) }
      it "一覧ページにアクセスした場合、Taskが表示されること" do
        task = FactoryBot.create(:task)
        login(user)
        visit tasks_path
        expect(page).to have_content task.content
        expect(Task.count).to eq 1
      end
    end
  end

  describe "#new" do
    context "未ログインユーザーの場合" do
      it "レスポンスステータスが302であることを確認後、ログインページに遷移" do
        get new_task_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "ログインユーザーの場合" do
      let(:user) { create(:user) }
      it "新規作成ページに遷移されること" do
        login(user)
        visit new_task_path
        expect(page).to have_content "提案する"
        expect(current_path).to eq new_task_path
      end
    end
  end

  describe "#create" do
    context "未ログインユーザーの場合" do
      it "レスポンスステータスが302であることを確認後、ログインページに遷移" do
        get new_task_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "ログインユーザーの場合" do
      let(:user) { create(:user) }
      it "正常系" do
        login(user)
        visit new_task_path
        task = FactoryBot.build(:task, user_id: user.id)
        expect(task).to be_valid
        expect(current_path).to eq new_task_path
        page.has_selector? '.alert-success', text: '過ごし方を提案しました'
      end

      it "必須項目(content)が入力されていない場合" do
        login(user)
        visit new_task_path
        task = FactoryBot.build(:task, content: "", user_id: user.id)
        expect(task).to_not be_valid
        expect(current_path).to eq new_task_path
        page.has_selector? '.alert-danger', text: '投稿に失敗しました'
      end

      it "必須項目(easy)が入力されていない場合" do
        login(user)
        visit new_task_path
        task = FactoryBot.build(:task, easy: "", user_id: user.id)
        expect(task).to_not be_valid
        expect(current_path).to eq new_task_path
        page.has_selector? '.alert-danger', text: '投稿に失敗しました'
      end

      it "必須項目(user_id)が入力されていない場合" do
        login(user)
        visit new_task_path
        task = FactoryBot.build(:task, user_id: "")
        expect(task).to_not be_valid
        expect(current_path).to eq new_task_path
        page.has_selector? '.alert-danger', text: '投稿に失敗しました'
      end
    end
  end

  describe "#edit" do
    let(:user) { create(:user) }
    let(:task) { create(:task) }

    context "未ログインユーザーの場合" do
      it "トップページに戻る" do
        visit edit_task_path(task)
        expect(current_path).to eq login_path
      end
    end

    context "ログイン後ユーザーの場合" do
      it "user_idが一致している場合、編集ページが表示される" do
        login(user)
        visit edit_task_path(task)
        page.has_content? task.content
      end

      it "user_idが一致していない場合、トップページへ戻る" do
        user2 = FactoryBot.create(:user)
        task2 = FactoryBot.create(:task, user_id: user2.id)
        login(user)
        visit edit_task_path(task2)
        expect(current_path).to eq root_path
      end
    end
  end

  describe "#update" do
    before do
      @user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user_id: other_user.id)
    end

    context "未ログインユーザーの場合" do
      it "ログインページへ遷移" do
        patch task_path(@task), params: { content: '新しい内容'}
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "ログインユーザーの場合" do
      it "user_idが一致している場合、更新できる" do
        @task = FactoryBot.create(:task, user_id: @user.id)
        login(@user)
        visit edit_task_path(@task)
        fill_in '過ごしかた案', with: '新しい内容'
        click_button "登録"
        expect(current_path).to eq suggested_list_path
        expect(@task.reload.content).to eq "新しい内容"
      end

      it "user_idが一致していない場合、トップページへ戻る" do
        login(@user)
        patch task_path(@task), params: { content: '新しい内容'}
        expect(current_path).to eq root_path
      end
    end
  end

  describe "#destroy" do
    before do
      @user = FactoryBot.create(:user)
      other_user = FactoryBot.create(:user)
      @task = FactoryBot.create(:task, user_id: other_user.id)
    end

    context "未ログインユーザーの場合" do
      it "ログインページへ遷移" do
        delete task_path(@task)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

#    context "ログインユーザーの場合" do
#      it "user_idが一致の場合、削除できる" do
#        @task = FactoryBot.create(:task, user_id: @user.id)
#        login(@user)
#        delete task_path(@task) # 投稿データを削除するリクエストを送る
#        expect(@task).not_to include @task
#      end
#      it "user_idが異なる場合、トップページへ遷移"
#    end
  end
end
