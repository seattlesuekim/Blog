class RenameTableThisTimeForReal < ActiveRecord::Migration
  def up
    rename_table :visitor, :visitors
  end

  def down
  end
end
