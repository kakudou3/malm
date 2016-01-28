namespace :create_diary do
  desc "create diary task"
  task :create do
    puts "create diary start"

    # itemsの各アイテムを文字列連結していく
    items = Item.all
    
    for item in items do
      joinedStr << item.text
      joinedStr << "\n"
    end
  end
end
