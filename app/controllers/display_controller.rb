class DisplayController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :terms_and_conditions]
  authorize_resource :class => false

	def index
    if current_user
      redirect_to :hood_select
    end
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
    @hoodsall = Neighborhood.where("picture_url_big is not null").total_stats.sort_by{|neigh| [-neigh.total_kilometers, -neigh.total_users]}
    @ranking = 0
  end

  def hood_detail
    @users = User.where("neighborhood_id = ?", params[:id]).paginate(:page => params[:page], :per_page => 20)
  end

  def coming_soon

  end

  def terms_and_conditions

  end
end
