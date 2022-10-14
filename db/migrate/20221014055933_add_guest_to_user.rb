class AddGuestToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :guest, :boolean, default: false, null: false
  end
end
