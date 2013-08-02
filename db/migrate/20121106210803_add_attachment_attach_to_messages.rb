class AddAttachmentAttachToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.has_attached_file :attach
    end
  end

  def self.down
    drop_attached_file :messages, :attach
  end
end
