class CreateThreadUsers < ActiveRecord::Migration
  def change
    create_table :thread_users do |t|
      t.boolean :deleted
      t.boolean :archived

      t.timestamps
    end
  end
end
