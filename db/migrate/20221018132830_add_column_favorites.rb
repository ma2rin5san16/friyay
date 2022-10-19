class AddColumnFavorites < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :status, :integer, null: false, default: 0
  end
end
