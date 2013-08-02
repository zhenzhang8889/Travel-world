class CreatePostreplies < ActiveRecord::Migration
  def change
    create_table :postreplies do |t|
      t.text :body
      t.integer :post_id

      t.timestamps
    end
  end
end
