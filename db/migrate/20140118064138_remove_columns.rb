class RemoveColumns < ActiveRecord::Migration
  def up
  end

  def down
    remove_column :visitors, :visits
    remove_column :visitors, :num_views
  end
end
