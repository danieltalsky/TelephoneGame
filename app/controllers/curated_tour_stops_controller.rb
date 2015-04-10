class CuratedTourStopsController < ApplicationController
  before_action :set_curated_tour, only: [:show]
  before_action :set_curated_tour_stops, only: [:show]
  
  caches_action :index, :show
  
  # GET /curated_tour_stops
  def index
    @curated_tour_stops = CuratedTourStop.order('curated_tour_stops.curated_tour_id, curated_tour_stops.sequential_id').all
  end

  # GET /curated_tour_stops/1
  def show
     @curated_tour_stops_count = @curated_tour.curated_tour_stop.count  
     @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end

  private

    def set_curated_tour
      @curated_tour = CuratedTour.find(params[:curated_tour_id])
    end

    def set_curated_tour_stops
      @curated_tour_stop = @curated_tour.curated_tour_stop.where(:sequential_id => params[:id]).first
    end

end