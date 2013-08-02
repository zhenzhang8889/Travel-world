class CreateActivitiesLeadGenerations < ActiveRecord::Migration
  def change
    create_table "activities_lead_generations", :id => false do |t|
      t.integer "lead_generation_id"
      t.integer "activity_id"
    end
  end
end
