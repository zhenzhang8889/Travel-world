class CreateActcates < ActiveRecord::Migration
  def change
    create_table :actcates do |t|
      t.string :name

      t.timestamps
    end
  end
end
