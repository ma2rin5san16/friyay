class CreateTaskDones < ActiveRecord::Migration[7.0]
  def change
    create_table :task_dones do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.string :comment
      t.integer :rationg, null: false

      t.timestamps
    end
  end
end
