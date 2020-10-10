class Admin::CuratedTourStopsController < Admin::ApplicationController
  before_action :set_curated_tour_stop, only: [:show, :edit, :update, :destroy]

  # GET /admin/curated_tour_stops
  def index
    @curated_tour_stops = CuratedTourStop.order('curated_tour_stops.curated_tour_id, curated_tour_stops.sequential_id').all
  end

  # GET /admin/curated_tour_stops/1
  def show
  end

  # GET /admin/curated_tour_stops/new
  def new
    @curated_tour_stop = CuratedTourStop.new
  end

  # GET /admin/curated_tour_stops/1/edit
  def edit
  end

  # POST /admin/curated_tour_stops
  def create
    @curated_tour_stop = CuratedTourStop.new(curated_tour_stop_params)

    if @curated_tour_stop.save
      redirect_to [:admin, @curated_tour_stop], notice: 'Curated tour stop was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/curated_tour_stops/1
  def update
    if @curated_tour_stop.update(curated_tour_stop_params)
      redirect_to [:admin, @curated_tour_stop], notice: 'Curated tour stop was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/curated_tour_stops/1
  def destroy
    @curated_tour_stop.destroy
    redirect_to admin_curated_tour_stops_url, notice: 'Curated tour stop was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curated_tour_stop
      @curated_tour_stop = CuratedTourStop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curated_tour_stop_params
      params.require(:curated_tour_stop).permit(:caption_text, :sequential_id, :work_id, :curated_tour_id)
    end
end
