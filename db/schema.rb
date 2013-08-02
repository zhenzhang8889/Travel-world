# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130214041503) do

  create_table "actcates", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities_lead_generations", :id => false, :force => true do |t|
    t.integer "lead_generation_id"
    t.integer "activity_id"
  end

  create_table "activities_profiles", :id => false, :force => true do |t|
    t.integer "activity_id"
    t.integer "profile_id"
  end

  create_table "addresses", :force => true do |t|
    t.string   "number"
    t.text     "street"
    t.string   "city"
    t.string   "region"
    t.string   "country"
    t.string   "zip"
    t.string   "phone"
    t.integer  "profile_id"
    t.boolean  "security"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "sub_area_url"
    t.text     "host_url"
    t.string   "atype"
    t.integer  "location_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.integer  "point"
    t.boolean  "is_active"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "category_badge_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_badges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "chattings", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "ltype",             :default => "country"
    t.string   "lorder",            :default => "99"
    t.integer  "location_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "traveler"
  end

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lead_generations", :force => true do |t|
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
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "ref_number"
  end

  create_table "lead_generations_notifications", :id => false, :force => true do |t|
    t.integer "lead_generation_id"
    t.integer "notification_id"
  end

  create_table "lead_generations_services", :id => false, :force => true do |t|
    t.integer "lead_generation_id"
    t.integer "service_id"
  end

  create_table "lead_replies", :force => true do |t|
    t.integer  "lead_generation_id"
    t.integer  "user_id"
    t.integer  "target_user_id"
    t.text     "body"
    t.boolean  "read",               :default => false
    t.boolean  "del_by_user",        :default => false
    t.boolean  "del_by_target_user", :default => false
    t.integer  "original_lead_id"
    t.integer  "target_lead_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "location_groups", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "lorder",     :default => 99
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "message_threads", :force => true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ack"
    t.string   "status"
    t.integer  "message_thread_id"
    t.integer  "user_id"
    t.string   "acked"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "subject"
    t.text     "body"
    t.datetime "read_at"
    t.boolean  "sender_deleted",      :default => false
    t.boolean  "recipient_deleted",   :default => false
  end

  create_table "notifications", :force => true do |t|
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
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.integer  "picturable_id"
    t.string   "picturable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "postreplies", :force => true do |t|
    t.text     "body"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "refer_to_id"
  end

  create_table "posts_refer_to_users", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  create_table "prof_avatars", :force => true do |t|
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
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "profile_types", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quick_messages", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "refertos", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "referable_id"
    t.string   "referable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id"], :name => "index_taggings_on_taggable_id"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "terms", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "thread_users", :force => true do |t|
    t.boolean  "deleted"
    t.boolean  "archived"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "message_thread_id"
  end

  create_table "user_completed_badges", :force => true do |t|
    t.integer "badge_id"
    t.integer "user_id"
    t.string  "note"
  end

  add_index "user_completed_badges", ["badge_id"], :name => "index_user_completed_badges_on_badge_id"
  add_index "user_completed_badges", ["user_id"], :name => "index_user_completed_badges_on_user_id"

  create_table "user_visit_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "visitor_id"
    t.integer  "service_id"
    t.integer  "lead_generation_id"
    t.string   "country"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "user_visit_histories", ["lead_generation_id"], :name => "index_user_visit_histories_on_lead_generation_id"
  add_index "user_visit_histories", ["service_id"], :name => "index_user_visit_histories_on_service_id"
  add_index "user_visit_histories", ["user_id"], :name => "index_user_visit_histories_on_user_id"
  add_index "user_visit_histories", ["visitor_id"], :name => "index_user_visit_histories_on_visitor_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "traveler",               :default => false
    t.string   "firstName"
    t.string   "lastName"
    t.string   "country"
    t.string   "city"
    t.string   "description"
    t.integer  "category_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "active",                 :default => true
    t.boolean  "is_enabled"
    t.string   "decrypted"
    t.boolean  "is_level2_admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "usracts", :force => true do |t|
    t.integer  "user_id"
    t.string   "atype"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "word_relations", :force => true do |t|
    t.integer  "word_id"
    t.integer  "related_id"
    t.integer  "ranking",    :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "words", :force => true do |t|
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
