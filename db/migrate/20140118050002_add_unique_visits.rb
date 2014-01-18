class AddUniqueVisits < ActiveRecord::Migration
  def change
    add_column :visits, :return_visits, :integer
  end

  def down
  end
end
