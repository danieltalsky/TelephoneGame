class WorksController < ApplicationController
  #before_filter :authorize
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  #caches_action :by_medium, :by_location, :tree
  
  # GET /works
  def index
    @works = Work.all
  end

  # GET /works/by_medium
  def by_medium
    @media = Work.uniq.pluck(:medium)
  
    @media_collection = Hash.new
    @media.each do |medium| 
        @media_collection[medium] = Work.where(:medium => medium)
    end
  end  
  
  # GET /works/by_location
  def by_location
    @locations = Artist.uniq.pluck(:location)  
    @location_collection = Hash.new
    @locations.each do |location| 
      @location_collection[location] = 
        Work.includes(:artist).where('artists.location = ?', location);
    end
    
    @countries = @locations.uniq {|location| location.split(', ').last }    
  end    
  
  # GET /works/tree
  def tree
    @works = Work.all
  end  
  
  # GET /works/old_tree
  def old_tree
    rootWork = Work.find_by_parent_id(nil)
    @treehtml = '<ul>' + generate_nested_list(rootWork) + '</ul>'
  end
  
  # GET /works/jsontree
  def jsontree
    render json: Work.all.to_json(
      :only  => [:id, :medium],
      :include => {:artist => {
        :only => [:name, :location]
    }})
  end  
  
  def generate_nested_list (node)
    ghtml = '<li><a>&nbsp;</a><span><a href="/works/%s" class="%s">%s</a></span>'%[node.id, node.medium, node.title]
    unless node.children.empty?
      ghtml << '<ul>'
      node.children.each do |childnode|
        ghtml << generate_nested_list(childnode)
      end
      ghtml << '</ul>'
    end
    ghtml << '</li>'
    ghtml
  end
  
  # GET /works/1
  def show
    @artist = Artist.find_by_id(@work.artist_id);
    if @work.children.empty?
      @random = Work.random
    end
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)  
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_params
      params.require(:work).permit(:title, :parent_id, :artist_id, :medium)
    end
end
