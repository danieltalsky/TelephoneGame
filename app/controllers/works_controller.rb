class WorksController < ApplicationController
  before_filter :authorize
  before_action :set_work, only: [:show, :edit, :update, :destroy]

  caches_action :by_medium, :by_location, :tree, :show, :old_tree, :jsontree
  
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
    
    @color_steps = get_color_steps @locations.count
    
    @locations.each_with_index do |location, index|
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
  
    def get_color_steps(total)
      # set up color transition
      startHSV   = {:h => 342, :s => 98.5, :v => 79.6}
      endHSV     = {:h => 194, :s => 95.7, :v => 91.0}
      
      diffHSV = {
        :h => (startHSV[:h] - endHSV[:h]), 
        :s => (startHSV[:s] - endHSV[:s]), 
        :v => (startHSV[:v] - endHSV[:v])
        } 
      increment = {}
      increment[:h] = diffHSV[:h].to_f / total
      increment[:s] = diffHSV[:s].to_f / total
      increment[:v] = diffHSV[:v].to_f / total
      
      lastStep = startHSV.dup
      steps = []
      steps << to_hsl_string(lastStep)
      (total - 1).times do 
        lastStep = { 
          :h => (lastStep[:h] - increment[:h]).round(2),
          :s => (lastStep[:s] - increment[:s]).round(2),  
          :v => (lastStep[:v] - increment[:v]).round(2)    
          }
        steps << to_hsl_string(lastStep)
      end
      steps << to_hsl_string(endHSV)
      steps
    end
  
    # Initialize a color based on RGB values. By default, the values
    # should be between 0 and 255. If you use the option <tt>:percent => true</tt>,
    # the values should then be between 0.0 and 1.0.
    def to_hsl_string(hsv_hash)
      
      hsl_hash = {}
      
      # determine the lightness in the range [0,100]
      hsl_hash[:l] = (2 - hsv_hash[:s] / 100) * hsv_hash[:v] / 2;
  
      l_calculation = (hsl_hash[:l] < 50 ? hsl_hash[:l] * 2 : 200 - hsl_hash[:l] * 2)
  
      # store the HSL components
      hsl_hash[:h] = hsv_hash[:h]
      hsl_hash[:s] = hsv_hash[:s] * ((l_calculation.nonzero?)?(hsv_hash[:v] / l_calculation):0)

      (hsl_hash[:h]).round.to_s + ',' + (hsl_hash[:s]).round.to_s + '%,' + (hsl_hash[:l]).round.to_s + '%'
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def work_params
      params.require(:work).permit(:title, :parent_id, :artist_id, :medium)
    end
end
