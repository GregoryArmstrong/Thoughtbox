require 'uri'

class LinksController < ApplicationController

  def index
    @link = Link.new
  end

  def create
    if valid_url?(params[:link][:url])
      Link.create(url: params[:link][:url], title: params[:link][:title])
    end
    redirect_to links_path
  end

  private

  def valid_url?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  end

end
