class CuratedToursController < ApplicationController
  before_action :set_curated_tour, only: [:show]

  # GET /curated_tours
  def index
    @curated_tours = CuratedTour.all
  end

  # GET /curated_tours/1
  def show
  end

end
