class CreateItemsImgs < ActiveRecord::Migration[5.2]
  def change
    create_table :items_imgs do |t|
      t.string     :url,  null: false
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
