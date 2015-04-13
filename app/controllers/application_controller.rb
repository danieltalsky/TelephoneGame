class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :populate_public_social_urls
  before_action :set_public_facebook_og_meta
  before_action :set_public_twitter_card_meta
  include Clearance::Controller
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
    # comb through a work to find its 
    def populate_public_social_urls
      @social_image_url = request.protocol + request.host_with_port + view_context.image_path('TelephoneSatelliteCollectiveSocialWork.png')
    end

    # set facebook og: metadata for works on the site
    def set_public_facebook_og_meta      
      og = {
        :title        => 'TELEPHONE',
        :description  => "An International Arts Experience Presented by Satellite Collective.  315 artists in 43 countries participated.",
        :type         => 'website',
        :url          => request.original_url,
        :image        => @social_image_url
      }         
      set_meta_tags :og => og
    end
      
    # set twitter card metadata for works on the site  
    def set_public_twitter_card_meta
      twitter = {
        :card  => 'summary',
        :site  => '@Sat_Collective',
        :title        => "TELEPHONE",
        :description  => "An International Arts Experience Presented by Satellite Collective.  315 artists in 43 countries participated.",
        :image => @social_image_url
      }    
      set_meta_tags :twitter => twitter
    end
end
