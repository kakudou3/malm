class ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def create
    item = Item.new
    item.text = params[:item][:text]
    item.save

    redirect_to :action => "index"
    # render :json => params[:item][:text]
  end
end
