class CreateUsracts < ActiveRecord::Migration
  def change
    create_table :usracts do |t|
      t.integer :user_id
      t.string :atype
      t.timestamps
    end
  end
end
