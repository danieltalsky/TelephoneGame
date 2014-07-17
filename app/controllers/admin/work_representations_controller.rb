class WorkRepresentationsController < ApplicationController
  before_action :set_work_representation, only: [:show, :edit, :update, :destroy]

  # GET /work_representations
  def index
    @work_representations = WorkRepresentation.all
  end

  # GET /work_representations/1
  def show
  end

  # GET /work_representations/new
  def new
    @work_representation = WorkRepresentation.new
  end

  # GET /work_representations/1/edit
  def edit
  end

  # POST /work_representations
  def create
    @work_representation = WorkRepresentation.new(work_representation_params)

    if @work_representation.save
      redirect_to @work_representation, notice: 'Work representation was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /work_representations/1
  def update
    if @work_representation.update(work_representation_params)
      redirect_to @work_representation, notice: 'Work representation was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /work_representations/1
  def destroy
    @work_representation.destroy
    redirect_to work_representations_url, notice: 'Work representation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_representation
      @work_representation = WorkRepresentation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_representation_params
      params.require(:work_representation).permit(:url, :fileext, :text_body_markdown, :work_id)
    end
end
