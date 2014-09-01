class CuratedTourStopsController < ApplicationController
  before_filter :authorize
  before_action :set_curated_tour_stops, only: [:show]
  
  # GET /curated_tour_stops
  def index
    @curated_tour_stops = CuratedTourStop.order('curated_tour_stops.curated_tour_id, curated_tour_stops.sequential_id').all
  end

  # GET /curated_tour_stops/1
  def show
     parentTour = CuratedTour.find_by_id(@curated_tour_stop.curated_tour_id)
     @curated_tour_stops_count = parentTour.curated_tour_stop.count  
     
     @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curated_tour_stops
      @curated_tour_stop = CuratedTourStop.find(params[:id])
    end

end
