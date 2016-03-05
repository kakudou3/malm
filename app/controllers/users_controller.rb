class UsersController < ApplicationController
  def index
    @user = User.new
    # ApplicationController.helpers.check_session
    #if ApplicationController.helpers.logged_in?
    #  redirect_to controller: 'items' , action: 'index'
    #end
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
      log_in @user
      # トップページへ戻る
      redirect_to :action => "index"
    else
      render 'signup'
    end
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
