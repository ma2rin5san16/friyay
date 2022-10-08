class RandomTasksController < ApplicationController
  def show
    @task = Task.order("RAND()").first
  end
end
