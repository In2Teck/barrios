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
      @hoodsall = Neighborhood.all
    end
  end

  def twitter_share
    #if it is shared, redirect to profile 
    if current_user.oauth_token
      redirect_to :profile
    end
  end

  def profile
    #Before release
    redirect_to :coming_soon 
    #@runs = current_user.runs if current_user.runs
  end

  def hood_ranking

  end

  def hood_detail

  end

  def coming_soon

  end

  def terms_and_conditions

  end
end
