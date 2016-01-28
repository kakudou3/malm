class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # success
      log_in user
      # redirect_to diary
      redirect_to controller: 'items', action: 'index'
    else
      # error
      flash.now[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render "new"
    end
  end

  def destroy
  end
end
