class DisplayController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index]
  authorize_resource :class => false

	def index

	end

  def hood_select
    if current_user.neighborhood_id
      if current_user.oauth_token 
        redirect_to :profile
      else
        redirect_to :twitter_share
      end
    else
      @hoods = Neighborhood.where("picture_url_big is not null")
    end

  end

  def twitter_share
    
  end

  def profile
    @runs = current_user.runs if current_user.runs
    #TODO: update current_user.first_twitt_id with @twitts[0].id
  end

  def hood_ranking

  end

  def hood_detail

  end

  def coming_soon

  end
end
