class DeleteColumns < ActiveRecord::Migration
  def up
    remove_column :visitors, :return_visits
    remove_column :visitors, :num_views
    change_column :visitors, :visits, :integer, :default => 0, :null => false
    change_column :visitors, :remember_token, :string, :null => false
  end

  def down
  end
end
