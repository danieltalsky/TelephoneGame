class Admin::ArtistsController < Admin::ApplicationController
  before_filter :authorize
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

  # GET /artists
  def index
    @artists = Artist.all
  end

  # GET /artists/1
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to [:admin, @artist], notice: 'Artist was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /artists/1
  def update
    if @artist.update(artist_params)
      redirect_to [:admin, @artist], notice: 'Artist was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /artists/1
  def destroy
    @artist.destroy
    redirect_to admin_artists_url, notice: 'Artist was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artist_params
      params.require(:artist).permit(:name, :contact, :bio, :url, :location)
    end
end
