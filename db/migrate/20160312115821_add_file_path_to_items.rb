class AddFilePathToItems < ActiveRecord::Migration
  def change
    add_column :items, :file_name, :string
    add_column :items, :file_path, :string
  end
end
