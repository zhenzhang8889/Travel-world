class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :number
      t.text :street
      t.string :city
      t.string :region
      t.string :country
      t.string :zip
      t.string :phone
      t.integer :profile_id
      t.boolean :security

      t.timestamps
    end
  end
end
