class SessionsController < ApplicationController

  def destroy
    cookies.delete :user_id
    redirect_to root_path
  end

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      cookies[:user_id] = @user.id
      if @user.registered_user?
        redirect_to links_path
      end
    else
      redirect_to login_path
    end
  end
end
