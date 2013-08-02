class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.attachment :data
      t.integer :user_id

      t.timestamps
    end
  end
end
