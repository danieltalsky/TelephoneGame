class CuratedToursController < ApplicationController
  before_filter :authorize
  before_action :set_curated_tours, only: [:show]

  caches_action :index, :show

  # GET /curated_tours
  def index
    @curated_tours = CuratedTour.all
  end

  # GET /curated_tours/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curated_tours
      @curated_tour = CuratedTour.find(params[:id])
    end

end
