class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :traveler, :boolean
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :description, :string
  end
end
