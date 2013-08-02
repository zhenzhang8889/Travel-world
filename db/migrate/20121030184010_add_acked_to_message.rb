class AddAckedToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :acked, :string
  end
end
