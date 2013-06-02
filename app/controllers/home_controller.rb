class HomeController < ApplicationController
  def index
    @feeds = Feed.order(:title).includes(:entries)
  end
end
