class AddReferToToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :refer_to_id, :integer
  end
end
