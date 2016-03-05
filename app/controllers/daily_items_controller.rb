class DailyItemsController < ApplicationController
  def index
    # 日報の一覧を表示する
    @daily_items = DailyItem.where("user_id = ?", session[:user_id]).order(created_at: :desc)
  end

  def show
    daily_item_id = params[:id]
    @daily_item = DailyItem.where("id = ?", daily_item_id).first
  end
end
