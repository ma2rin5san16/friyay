class ChangeEvaluatesToRatings < ActiveRecord::Migration[7.0]
  def change
    rename_table :evaluates, :ratings
  end
end