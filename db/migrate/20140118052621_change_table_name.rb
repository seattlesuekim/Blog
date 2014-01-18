class ChangeTableName < ActiveRecord::Migration
  def up
    rename_table :visits, :visitor
  end

  def down
  end
end
