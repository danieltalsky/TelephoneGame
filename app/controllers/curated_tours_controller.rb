class CuratedToursController < ApplicationController
  before_action :set_curated_tour, only: [:show, :edit, :update, :destroy]

  # GET /curated_tours
  def index
    @curated_tours = CuratedTour.all
  end

  # GET /curated_tours/1
  def show
  end

  # GET /curated_tours/new
  def new
    @curated_tour = CuratedTour.new
  end

  # GET /curated_tours/1/edit
  def edit
  end

  # POST /curated_tours
  def create
    @curated_tour = CuratedTour.new(curated_tour_params)

    if @curated_tour.save
      redirect_to @curated_tour, notice: 'Curated tour was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /curated_tours/1
  def update
    if @curated_tour.update(curated_tour_params)
      redirect_to @curated_tour, notice: 'Curated tour was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /curated_tours/1
  def destroy
    @curated_tour.destroy
    redirect_to curated_tours_url, notice: 'Curated tour was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_curated_tour
      @curated_tour = CuratedTour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def curated_tour_params
      params[:curated_tour].permit(:tour_author, :tour_name)
    end
end
