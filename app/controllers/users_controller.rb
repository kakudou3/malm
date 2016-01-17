class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def login
    @user = User.new
  end

  def signup
    @user = User.new
  end
end
