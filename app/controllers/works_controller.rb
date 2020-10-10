class WorksController < ApplicationController

  before_action :set_work, only: [:show, :edit, :update, :destroy]

  caches_action :index, :by_medium, :by_location, :tree, :show, :old_tree, :jsontree
  
  # GET /works
  def index
    @works = Work.all
  end

  # GET /works/1
  def show
    @artist = Artist.find_by_id(@work.artist_id);
    if @work.children.empty?
      @random = Work.random
    end
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)  
    
    populate_social_urls
    set_facebook_og_meta
    set_twitter_card_meta
  end

  # GET /works/by_medium
  def by_medium
    @media = Work.all.pluck(:medium)
  
    @media_collection = Hash.new
    @media.each do |medium| 
        @media_collection[medium] = Work.where(:medium => medium)
    end
  end  
  
  # GET /works/by_location
  def by_location
    @locations = Artist.pluck(:location)  
    @location_collection = Hash.new
    
    @color_steps = get_color_steps @locations.count
    
    @locations.each do |location|
      @location_collection[location] = Work.joins(:artist).where('artists.location = ?', location);
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

  private

    # comb through a work to find its 
    def populate_social_urls
      @social_work_url = url_for(:controller => :works, :only_path => false)+'/'+@work.id.to_s;
      @social_work_title = "TELEPHONE #{@work.medium.downcase} work by #{@artist.name}"
      @social_work_description = "#{@artist.name} created this work as a part of the international art game TELEPHONE.  315 artists in 43 countries participated."
      
      @default_image_url = request.protocol + request.host_with_port + view_context.image_path('TelephoneSatelliteCollectiveSocialWork2.png')
      
      @social_image_url = false
      @debug = []
      @work.work_representations.each do |wr|
        if ['gif','jpg','png'].include?(wr.fileext.downcase) && !@social_image_url then @social_image_url = view_context.work_image_url(wr.url, :lightbox, false) end
      end
 
      if !@social_image_url then @social_image_url = @default_image_url end
    end

    # set facebook og: metadata for works on the site
    def set_facebook_og_meta      
      og = {
        :title        => @social_work_title,
        :description  => @social_work_description,
        :type         => 'website',
        :url          => @social_work_url
      }   
      
      if @social_image_url.is_a? String then og[:image] = @social_image_url end
      
      set_meta_tags :og => og
    end
      
    # set twitter card metadata for works on the site  
    def set_twitter_card_meta
      twitter = {
        :card  => 'summary',
        :site  => '@Sat_Collective',
        :title        => @social_work_title,
        :description  => @social_work_description,
        :image => @social_image_url
      }
      
      set_meta_tags :twitter => twitter
    end
  
    # Get color steps for the custom by_location headers
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
