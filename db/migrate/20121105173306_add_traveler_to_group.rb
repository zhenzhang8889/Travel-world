class AddTravelerToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :traveler, :boolean
  end
end
