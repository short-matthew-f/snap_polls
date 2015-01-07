class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :poll
      
      t.string :content
      t.boolean :correct, default: false

      t.timestamps null: false
    end
  end
end
