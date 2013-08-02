class CreateUserVisitHistories < ActiveRecord::Migration

  def up
    create_table :user_visit_histories do |t|
      t.integer :user_id, :visitor_id, :service_id, :lead_generation_id
      t.string :country
      t.timestamps
    end
    add_index :user_visit_histories,  :user_id
    add_index :user_visit_histories, :visitor_id
    add_index :user_visit_histories, :service_id
    add_index :user_visit_histories, :lead_generation_id
  end

  def down
    drop_table :user_visit_histories
  end

end
