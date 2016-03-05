class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      # success
      log_in @user

      # remember user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
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

end
