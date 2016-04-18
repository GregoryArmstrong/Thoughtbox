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

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if params[:switch]
      @link.read = !@link.read
      @link.save
    elsif (params[:link][:url] || params[:link][:title]) && valid_url?(params[:link][:url])
      @link.update_attributes(url: params[:link][:url],
                              title: params[:link][:title])
    end
    redirect_to links_path
  end

  private

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  end

end
