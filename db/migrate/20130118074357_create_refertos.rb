class CreateRefertos < ActiveRecord::Migration
  def change
    create_table :refertos do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :referable_id
      t.string :referable_type

      t.timestamps
    end
  end
end
