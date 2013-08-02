class CreateProfiles < ActiveRecord::Migration
  def change
    create_table "profiles" do |t|
      t.string   "name"
      t.text     "activity_details"
      t.string   "website"
      t.string   "marketing_network"
      t.string   "country"
      t.string   "region"
      t.string   "street"
      t.string   "city"
      t.string   "freephone"
      t.string   "phone"
      t.string   "fax"
      t.string   "business_hours"
      t.integer  "user_id"
      t.integer  "step",                   :default => 0
      t.integer  "activity_id"
      t.integer  "month_enhanced"
      t.integer  "year_enhanced"
      t.integer  "month_product_launched"
      t.integer  "year_product_launched"
      t.string   "product_status"
      t.integer  "qualmark_accredited"
      t.integer  "qualmark_rating"
      t.string   "suburb"
      t.boolean  "commission"
      t.string   "rooms"
      t.string   "capacity"
      t.string   "duration"
      t.string   "larger_org"
      t.string   "min_age"
      t.string   "months_of_operation"
      t.string   "languages"
      t.string   "collateral"
      t.string   "retail_rate"
      t.string   "child_rate"
      t.text     "pricing_info"
      t.text     "cancellation"
      t.text     "facilities"
      t.text     "media_angle"
      t.integer  "domestic"
      t.integer  "international"
      t.integer  "independent"
      t.integer  "groups"
      t.text     "promote"
      t.text     "brochures"
      t.integer  "country_id"
      t.integer  "service_id"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.integer  "profile_type_id"
      t.string   "cover_file_name"
      t.string   "cover_content_type"
      t.integer  "cover_file_size"
      t.datetime "cover_updated_at"
      t.string   "cover_type",             :default => "single"
      t.string   "time_zone"
      t.integer  "tourist_type_id"
      t.boolean  "open_for_public",        :default => true
      t.boolean  "open_for_member",        :default => false
      t.boolean  "term",                   :default => false
      t.string   "twitter"
      t.string   "facebook"
      t.string   "google_plus"
      t.string   "tumblr"
      t.integer  "view_times",             :default => 0
      t.integer  "looking_for_service_id"
      t.integer  "providing_service_id"
      t.string   "show_location",          :default => "both"
      t.text     "slug"
      t.string   "contact_button",         :default => "Hire Me"
      t.boolean  "show_contact_button",    :default => true
      t.boolean  "avatar_croped",          :default => true
      t.integer  "area_id"
      t.boolean  "recommend",              :default => false

      t.timestamps
    end

  end
end
