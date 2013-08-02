class CreateActivitiesProfiles < ActiveRecord::Migration
  def change
    create_table "activities_profiles", :id => false do |t|
      t.integer "activity_id"
      t.integer "profile_id"
    end
  end
end
