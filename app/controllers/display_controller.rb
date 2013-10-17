class DisplayController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index, :terms_and_conditions, :hood_ranking, :hood_detail, :redirect]
  authorize_resource :class => false

  def admin
    @users_count = User.all.count
    @users_with_km_count = User.where("kilometers > 0").count
    @users_with_fb_problems = User.where("access_token is null")
    @users_with_tw_problems = User.where("oauth_token is null and oauth_token_secret is null")
    render :layout => "application"
  end

  def closed_registration
  
  end

  def print_attendees
    @users = User.where("attendee = ?", true)
    render :layout => "application"
  end

  def csv
    @users = User.where("attendee = ?", true)
    respond_to do |format|
      format.csv { send_data @users.to_csv }
      format.xls
    end 
  end

  def csv_all_users
    @users = User.all
    respond_to do |format|
      format.csv { send_data @users.to_csv }
      format.xls
    end
  end

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

  def hood_reselect
    current_user.update_attribute(:neighborhood_id, nil)
    redirect_to :hood_select
  end

  def confirm_attendance 
    if (not current_user.attendee) and User.maximum("register_number") <= 1501
      current_user.update_attribute(:attendee, true)
      current_user.update_attribute(:register_number, User.maximum("register_number") + 1)
      #send email
      redirect_to :print_screen
    else
      logger.error ("no hay cupo ya")
      redirect_to :closed_registration
    end
  end

  def print_screen
    if not current_user.attendee
      if User.maximum("register_number") >= 1501 
        # redirect to NO HAY CUPO
        logger.error ("no hay cupo ya")
        redirect_to :closed_registration
      else
        redirect_to :race_invite
      end
    end
  end

  def race_invite
    if current_user.attendee
      redirect_to :print_screen
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
    #  redirect_to :coming_soon
    if not current_user.neighborhood_id
      redirect_to :hood_select
    end
  end

  def hood_ranking
    @hoodsall = Neighborhood.where("picture_url_big is not null").total_stats.sort_by{|neigh| [-neigh.total_kilometers, -neigh.total_users]}
    @ranking = 0
  end

  def hood_detail
    @current_hood = Neighborhood.find(params[:id])
    @users = User.where("neighborhood_id = ?", params[:id]).order('kilometers desc').paginate(:page => params[:page], :per_page => 20)
  end

  def coming_soon

  end

  def terms_and_conditions

  end

  def redirect 
    redirect_to "/redirect.html"
  end
end
