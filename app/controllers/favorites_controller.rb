class FavoritesController < ApplicationController
  before_action :set_task, only:[:edit, :update, :create, :destroy]
  before_action :set_favorite, only:[:edit, :update]
  before_action :status_evaluated?, only:[:edit, :update]

  def toggle_status
    @favorite = Favorite.find(params[:favorite_id])
    @favorite.toggle_status!
    redirect_to current_user, success: 'ステータスを更新しました'
  end

  def index
    #お気に入りずみのタスクレコードを取得
    @favorite_tasks = current_user.favorite_tasks.order(created_at: :desc)
    @favorites = current_user.favorites
  end

  def create
    @favorite = Favorite.create(user_id: current_user.id, task_id: @task.id)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, task_id: @task.id)
      if @favorite.user_id == current_user.id
        @favorite.destroy
      end
  end

  def edit; end

  def update
    if @favorite.update(rating_params)
      redirect_to current_user, success: "評価しました"
    else
      flash.now[:danger] = "評価に失敗しました"
      render 'edit'
    end
  end

  private
    def rating_params
      params.require(:favorite).permit(:comment, :rating)
    end

    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    def status_evaluated?
      if @favorite.unevaluated?
        redirect_to current_user, danger: "未実行なため、評価できません"
      end
    end
end
