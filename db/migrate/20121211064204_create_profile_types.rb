class CreateProfileTypes < ActiveRecord::Migration
  def change
    create_table :profile_types do |t|
      t.string :code
      t.string :name

      t.timestamps
    end
  end
end
