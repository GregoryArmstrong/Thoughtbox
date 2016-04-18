class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:user_id] = @user.id
      registered_user_role = Role.find_by(name: "registered_user")
      @user.roles << registered_user_role
      redirect_to links_path
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation)
  end

end
