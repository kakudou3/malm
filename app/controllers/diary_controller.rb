class DiaryController < ApplicationController
  def index
    @item = Item.new
  end

  def create
    render "index"
  end

  def log

  end

  def setting

  end
end
