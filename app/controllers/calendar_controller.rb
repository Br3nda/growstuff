class CalendarController < ApplicationController
  before_action :authenticate_member!, except: %i(index hierarchy search show)
  skip_authorize_resource only: %i(hierarchy search)
  respond_to :html, :json, :rss, :csv
  responders :flash
  def index
    @hemisphere = :south
    @plantings = Planting.all
    @harvests = Harvest.all
  end
end
