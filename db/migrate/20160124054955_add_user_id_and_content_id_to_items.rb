class AddUserIdAndContentIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :user_id, :integer
    add_column :items, :content_id, :integer
  end
end
