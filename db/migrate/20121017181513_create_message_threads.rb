class CreateMessageThreads < ActiveRecord::Migration
  def change
    create_table :message_threads do |t|
      t.string :subject

      t.timestamps
    end
  end
end
