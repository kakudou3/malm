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

  def create
    @user = User.new(user_params)

    if @user.save
      # Handle a successful save.
      # redirect_to @user

      # トップページへ戻る
      redirect_to :action => "index"
    else
      render 'signup'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
