class CreateNotifications < ActiveRecord::Migration
  def change

    create_table "notifications" do |t|
      t.integer  "user_id"
      t.integer  "kind"
      t.string   "message"
      t.string   "link"
      t.integer  "contact_id"
      t.string   "state",                :default => "new"
      t.string   "noti_type"
      t.integer  "users_following_id"
      t.boolean  "read",                 :default => false
      t.boolean  "is_del",               :default => false
      t.integer  "lead_generation_id"
      t.integer  "signup_invitation_id"
      t.timestamps
    end

    add_index "notifications", ["user_id"]
  end
end
