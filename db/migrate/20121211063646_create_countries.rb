class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code
      t.string :name
      t.string :ltype, :default => "country"
      t.string :lorder, :default => 99
      t.integer :location_group_id

      t.timestamps
    end
  end
end
