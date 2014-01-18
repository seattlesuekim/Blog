class CreateVisits < ActiveRecord::Migration
  def up
    create_table :visits do |t|
      t.string  :remember_token
      t.integer :visits
      t.integer :num_views
    end
  end

  def down
  end
end
