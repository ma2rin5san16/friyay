class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :content, null: false
      t.string :prepare
      t.integer :easy, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
