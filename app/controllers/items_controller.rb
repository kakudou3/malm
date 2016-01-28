class ItemsController < ApplicationController
  def index
    @item = Item.new

    if request.post?
      @item.text = params[:item][:text]

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
      @items = Item.all
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
