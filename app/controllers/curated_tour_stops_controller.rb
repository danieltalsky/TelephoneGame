class CuratedTourStopsController < ApplicationController
  before_action :set_curated_tour_stop, only: [:show]

  # GET /curated_tour_stops
  def index
    @curated_tour_stops = CuratedTourStop.order('curated_tour_stops.curated_tour_id, curated_tour_stops.sequential_id').all
  end

  # GET /curated_tour_stops/1
  def show
  end

end
