class AddDefaultsToUserColumns < ActiveRecord::Migration
  def change
  	change_column :users, :traveler, :boolean, :default => false
  end
end
