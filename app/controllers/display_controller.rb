class DisplayController < ApplicationController

  #before_filter

	def index

	end

  def hood_select
    @hoods = Neighborhood.all
  end

  def twitter_share
    
  end

  def profile
    @runs = current_user.runs 
    #TODO: update current_user.first_twitt_id with @twitts[0].id
  end

  def hood_ranking

  end

  def hood_detail

  end
end
