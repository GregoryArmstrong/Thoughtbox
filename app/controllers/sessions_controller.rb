class SessionsController < ApplicationController

  def destroy
    cookies.delete :user_id
    redirect_to root_path
  end

end
