class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :parent_id
      t.text :sub_area_url
      t.text :host_url
      t.string :atype
      t.integer :location_group_id

      t.timestamps
    end
  end
end
