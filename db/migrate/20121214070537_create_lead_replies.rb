class CreateLeadReplies < ActiveRecord::Migration
  def change

    create_table "lead_replies" do |t|
      t.integer  "lead_generation_id"
      t.integer  "user_id"
      t.integer  "target_user_id"
      t.text     "body"
      t.boolean  "read",               :default => false
      t.boolean  "del_by_user",        :default => false
      t.boolean  "del_by_target_user", :default => false
      t.integer  "original_lead_id"
      t.integer  "target_lead_id"
      t.timestamps
    end

  end
end
