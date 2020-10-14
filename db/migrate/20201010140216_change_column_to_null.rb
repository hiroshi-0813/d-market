class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column_null :items, :size_id, true
    change_column_null :items, :category, true
    change_column_null :items, :trading_status, true
  end
  
  def down
    change_column_null :items, :size_id, false
    change_column_null :items, :category, false
    change_column_null :items, :trading_status, false
  end
end
