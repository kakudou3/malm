class DailyItemsController < ApplicationController
  def index
    # 日報の一覧を表示する
    @daily_items = DailyItem.where("user_id = ?", session[:user_id])
  end

  def show
  end
end
