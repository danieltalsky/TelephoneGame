class Admin::CuratedToursController < Admin::ApplicationController
  before_action :set_curated_tour, only: [:show, :edit, :update, :destroy]

  # GET /admin/curated_tours
  def index
    @curated_tours = CuratedTour.all
  end

  # GET /admin/curated_tours/1
  def show
  end

  # GET /admin/curated_tours/new
  def new
    @curated_tour = CuratedTour.new
  end

  # GET /admin/curated_tours/1/edit
  def edit
  end

  # POST /admin/curated_tours
  def create
    @curated_tour = CuratedTour.new(curated_tour_params)

    if @curated_tour.save
      redirect_to [:admin, @curated_tour], notice: 'Curated tour was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/curated_tours/1
  def update
    if @curated_tour.update(curated_tour_params)
      redirect_to [:admin, @curated_tour], notice: 'Curated tour was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/curated_tours/1
  def destroy
    @curated_tour.destroy
    redirect_to admin_curated_tours_url, notice: 'Curated tour was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curated_tour
      @curated_tour = CuratedTour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curated_tour_params
      params.require(:curated_tour).permit(:tour_author, :tour_name, :published)
    end
end
