class CreateQuickMessages < ActiveRecord::Migration
  def change
    create_table :quick_messages do |t|
      t.text :body

      t.timestamps
    end
  end
end
