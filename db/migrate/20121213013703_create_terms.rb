class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.text :body

      t.timestamps
    end
  end
end
