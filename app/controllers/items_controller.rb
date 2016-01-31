class ItemsController < ApplicationController
  def index
    @item = Item.new

    if request.post?
      @item.text = params[:item][:text]
      @item.user_id = session[:user_id]

      respond_to do |format|
        if @item.save
          @postitem = Item.last
          format.html
          format.js
        else
          format.js { render :index }
        end
      end
    else
      @items = Item.where("user_id = ? and created_at >= ?", session[:user_id], Time.zone.now.beginning_of_day)
      # logger.debug @items[0].text
      # @items = Item.all
    end
  end

  def create
    item = Item.new
    item.text = params[:item][:text]

    respond_to do |format|
      if item.save
        format.html
        format.js {render :index }
      else
        format.js { render :index }
      end
    end

    # redirect_to :action => "index"
    # render index
  end
end
