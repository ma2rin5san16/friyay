class AddColmnToFavorite < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :comment, :string
    add_column :favorites, :rating, :integer
  end
end
