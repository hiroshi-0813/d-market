class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string     :first_name,	      null: false
      t.string     :family_name,      null: false
      t.string     :first_name_kana,  null: false
      t.string     :family_name_kana,	null: false
      t.string     :phone_number,	    unique:true
      t.date       :birth_year,	      null: false
      t.date       :birth_month,      null: false
      t.integer :user,             null:false, foreign_key: true
      t.text       :introductin
      t.timestamps
    end
  end
end
