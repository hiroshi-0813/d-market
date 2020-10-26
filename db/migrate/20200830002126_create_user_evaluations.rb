class CreateUserEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_evaluations do |t|
      t.text :review,                       null: false
      t.integer :user_id,	                  null: false, foreign_key: true
      t.references :item,                   null: false, foreign_key: true
      t.integer :evalution_id, null: false
      t.timestamps
    end
  end
end
