class CreateWords < ActiveRecord::Migration

  def change

    create_table "words" do |t|
      t.string   "value"
      t.timestamps
    end

    create_table "word_relations" do |t|
      t.integer  "word_id"
      t.integer  "related_id"
      t.integer  "ranking",    :default => 0
      t.timestamps
    end

  end

end
