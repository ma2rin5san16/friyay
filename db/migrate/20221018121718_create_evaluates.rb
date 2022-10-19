class CreateEvaluates < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluates do |t|
      t.string :comment
      t.integer :rating

      t.timestamps
    end
  end
end
