class AlterUsersAddDecrypted < ActiveRecord::Migration

  def up
    add_column :users, :decrypted, :string
  end

  def down
    remove_column :users, :decrypted
  end
end
