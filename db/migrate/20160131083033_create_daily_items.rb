class CreateDailyItems < ActiveRecord::Migration
  def change
    create_table :daily_items do |t|
      t.string :content
      t.integer :user_id
      t.integer :content_id

      t.timestamps null: false
    end
  end
end
