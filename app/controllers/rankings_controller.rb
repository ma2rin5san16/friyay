class RankingsController < ApplicationController
  before_action :logged_in_user

  def index

    @tasks = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))


    #選択された数字がインスタンスに代入される
    @range = params[:range]
    @gender = params[:gender]

    if @range == "1" || @gender == "1"
      @tasks = Task.find(Favorite.with_user.search_with_gender(0).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "1" || @gender == "2"
    @tasks = Task.find(Favorite.with_user.search_with_gender(1).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "2" || @gender == "1"
      @tasks = Task.find(Favorite.with_user.search_with_gender(0).search_with_weekly.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "2" || @gender == "2"
      @tasks = Task.find(Favorite.with_user.search_with_gender(1).search_with_weekly.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "1"
      @tasks = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @range == "2"
      @tasks = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @gender == "1"
      @tasks = Task.find(Favorite.with_user.search_with_gender(0).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    elsif @gender == "2"
      @tasks = Task.find(Favorite.with_user.search_with_gender(1).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    end

    @favorite = Favorite.find_by(user_id: current_user.id)

    #週間ランキング
    #@weekly_rank = Task.find(Favorite.group_by_task.search_with_weekly.order('count(task_id) desc').limit(3).pluck(:task_id))

   #全期間ランキング
    #@all_rank = Task.find(Favorite.group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))

    #男女別全期間ランキング
    #@male_all_rank = Task.find(Favorite.with_user.search_with_gender(0).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))
    #@female_all_rank = Task.find(Favorite.with_user.search_with_gender(1).group_by_task.order('count(task_id) desc').limit(3).pluck(:task_id))

   # 年代別生まれ全期間ランキング
    #@generate_2000_all_rank = Task.find(Favorite.with_user.birth_between("2000-01-01", Time.now).group(:task_id).order('count(task_id) desc').limit(3).pluck(:task_id))
    #@generate_1990_all_rank = Task.find(Favorite.with_user.birth_between("1990-01-01", '1999-12-31').group(:task_id).order('count(task_id) desc').limit(3).pluck(:task_id))
    #@generate_1980_all_rank = Task.find(Favorite.with_user.birth_between("1980-01-01", '1989-12-31').group(:task_id).order('count(task_id) desc').limit(3).pluck(:task_id))
    #@generate_1970_all_rank = Task.find(Favorite.with_user.birth_between(nil, '1979-12-31').group(:task_id).order('count(task_id) desc').limit(3).pluck(:task_id))
  end

  private
end
