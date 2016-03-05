class ItemsController < ApplicationController
  def index
    @item = Item.new

    if request.post?
      @item.text = params[:item][:text]
      @item.user_id = session[:user_id]

      respond_to do |format|
        if @item.save
          @postitem = Item.last
          @posturls = ApplicationController.helpers.get_urls_from_text(@postitem.text)
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

  # 編集
  def edit
    if request.post?
      @edit_item = Item.where("id = ?", params[:id]).first
      @edit_item.update(text: params[:text])

      respond_to do |format|
        format.json { render :json => @edit_item }
      end
    else
      render nothing: true
    end
  end

  # 削除
  def delete
    if request.post?
      @delete_item = Item.where("id = ?", params[:id]).first
      @delete_item.destroy

      respond_to do |format|
        format.json { render :json => @delete_item }
      end
    else
      render nothing: true
    end
    # render nothing: true
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
