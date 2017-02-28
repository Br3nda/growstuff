class SquaresController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @garden = Garden.find(params[:garden_id])
    @plantings = @garden.plantings.current
    @squares = Square.find_by(garden: @garden.id)
    respond_with(@squares)
  end

  def show
    respond_with(@square)
  end

  def update
    @garden.update(square_params)
    respond_with(@garden)
  end

  def destroy
    @garden.update(square_params)
    respond_with(@garden)
  end

  private

  def square_params
    params.require(:square).permit(:id, :x, :y, :garden_id)
  end
end
