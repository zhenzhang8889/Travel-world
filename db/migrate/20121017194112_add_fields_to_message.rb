class AddFieldsToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :ack, :boolean
    add_column :messages, :status, :string
    add_column :messages, :message_thread_id, :integer
  end
end
