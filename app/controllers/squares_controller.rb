class SquaresController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @garden = Garden.find(params[:garden_id])
  end
end
