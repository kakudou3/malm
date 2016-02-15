class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    user = User.find_by(email: params[:user][:email].downcase)

    if user && user.authenticate(params[:user][:password])
      # success
      log_in user
      # redirect_to diary
      redirect_to controller: 'items', action: 'index'
    else
      flash.now[:danger] = '入力内容に不備があります'
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to controller: 'users' , action: 'index'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
