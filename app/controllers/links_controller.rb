require 'uri'

class LinksController < ApplicationController

  def index
    @link = Link.new
    @links = Link.where(user_id: cookies[:user_id])
  end

  def create
    if valid_url?(params[:link][:url])
      @user = User.find(cookies[:user_id])
      @user.links.create(url: params[:link][:url], title: params[:link][:title])
    else
      flash[:error] = "Invalid URL Submitted."
    end
    redirect_to links_path
  end

  private

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  end

end
