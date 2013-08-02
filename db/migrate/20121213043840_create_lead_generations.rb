class CreateLeadGenerations < ActiveRecord::Migration
  def change
    create_table "lead_generations" do |t|
      t.string   "lg_type"
      t.integer  "location_id"
      t.string   "lg_state",        :default => "live"
      t.integer  "user_id"
      t.float    "rank",            :default => 0.0
      t.string   "lg_product_type"
      t.text     "subject"
      t.text     "details"
      t.integer  "area_id"
      t.text     "area_desc"
      t.integer  "sub_area_id"
      t.integer  "traveller_id"
      t.integer  "service_id"
      t.date     "start_date"
      t.date     "end_date"
      t.boolean  "is_today"
      t.boolean  "call_me"
      t.boolean  "email_me"
      t.boolean  "proftag",         :default => false

      t.timestamps
    end

    create_table "lead_generations_notifications", :id => false do |t|
      t.integer "lead_generation_id"
      t.integer "notification_id"
    end

    create_table "lead_generations_services", :id => false do |t|
      t.integer "lead_generation_id"
      t.integer "service_id"
    end
  end
end
