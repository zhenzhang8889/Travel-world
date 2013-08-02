class CreateProfAvatars < ActiveRecord::Migration
  def change
    create_table "prof_avatars" do |t|
      t.float    "chop_x"
      t.float    "chop_y"
      t.float    "chop_h"
      t.float    "chop_w"
      t.integer  "profile_id"
      t.string   "p_state",           :default => "active"
      t.string   "data_file_name"
      t.string   "data_content_type"
      t.integer  "data_file_size"
      t.datetime "data_updated_at"

      t.timestamps
    end

  end
end
