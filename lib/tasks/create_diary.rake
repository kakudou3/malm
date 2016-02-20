namespace :create_diary do
  desc "create diary task"
  task :create => :environment do
    puts "create diary start"

    # バッチ処理をおこなう際はsession情報は関係なく 裏でuser_id 1から順に集計処理を実行していかなければならない

    # itemsの各アイテムを文字列連結していく
    #items = Item.where("user_id = ? and created_at = ?", session[:user_id], 1.day.ago.all_day)

    # 全ユーザーに対してバッチ処理を行う
    user_num = User.count("id")
    puts user_num

    users = User.all

    range = 1.day.ago.all_day

    for user in users do
      puts range
      items = Item.where("user_id = ? and created_at = ?", user.id, [range])

      joinedStr = nil
      for item in items do
        joinedStr << item.text
        joinedStr << "\n"
      end

      diary_item = DailyItem.new
      diary_item.content = joinedStr
      diary_item.user_id = user.id
      diary_item.save()
    end

    #joinedStr = nil
    #for item in items do
    #  joinedStr << item.text
    #  joinedStr << "\n"
    #end
  end
end
