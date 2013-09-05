class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable 
  
  MILE_TO_KM = 1.609344
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :twitter_id, :first_name, :last_name, :roles, :access_token, :oauth_token, :oauth_token_secret, :facebook_hash, :twitter_hash, :last_twitt_id, :last_facebook_run, :neighborhood_id, :kilometers

  has_and_belongs_to_many :roles
  has_many :runs
  has_many :facebook_runs
  has_many :twitter_runs
  belongs_to :neighborhood

  #validates_presence_of :email, :password

	def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
		user = User.where(:email => auth.info.email).first
		if not user
			# CHECK FOR NEW/CREATE
			user = User.create(first_name:auth.info.first_name, last_name:auth.info.last_name, facebook_id:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20], access_token:auth.credentials.token, facebook_hash:auth, last_facebook_run:Time.now, kilometers:0)
    elsif not user.access_token
      user.update_attribute(:access_token, auth.credentials.token)
		end
		user
	end

  def self.find_for_twitter_oauth(auth_hash, signed_in_resource = nil)
		user = User.find_by_twitter_id auth_hash.uid
		if (not user) and signed_in_resource
      user_twitter = Twitter::Client.new(
        :oauth_token => auth_hash.credentials.token,
        :oauth_token_secret => auth_hash.credentials.secret,
        :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
        :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'])
      last_twitt_id = user_twitter.user_timeline[0].id
			signed_in_resource.update_attributes({:twitter_id => auth_hash.uid, :oauth_token => auth_hash.credentials.token, :oauth_token_secret => auth_hash.credentials.secret, :twitter_hash => auth_hash, :last_twitt_id => last_twitt_id})
    elsif (not user.oauth_token) and (not user.oauth_token_secret) and signed_in_resource
      signed_in_resource.update_attributes({:oauth_token => auth_hash.credentials.token, :oauth_token_secret => auth_hash.credentials.secret})
		end
		user || signed_in_resource
	end 

  def self.update_runs
    users = User.all
    users.each do |user|
      if user.access_token
        user.save_fb_runs
      end
      if user.oauth_token
        user.save_tw_runs
      end
      user.save_total_kilometers
    end
  end

	def role?(role)
		return !!self.roles.find_by_name(role)
	end

  def query_fb_runs
    begin
      rg = RestGraph.new(:access_token => self.access_token)
      return rg.get('me/fitness.runs')
    rescue => error
      if[458, 460].index(e.error["error"]["error_subcode"])
        self.update_attribute(:access_token, nil)
        User.log_parse_error "User #{self.id} without FB permissions or with password changed, needs to log back in"
      else
        User.log_error self, error
      end
      return nil
    end
  end

  def save_fb_runs
    runs = self.query_fb_runs
    user_last_run = self.last_facebook_run || self.created_at
    if runs 
      runs["data"].each do |run|
        if not Run.find_by_run_id(URI.parse(run["data"]["course"]["url"]).path.split("/").last) and user_last_run < run["publish_time"] 
          begin
            fb_run = Run.new(:user_id => self.id, :run_url => run["data"]["course"]["url"], :run_id => URI.parse(run["data"]["course"]["url"]).path.split("/").last, :kilometers => distance_in_km_for_fb(run["data"]["course"]["title"]), :published_date => run["publish_time"], :start_date =>run["start_time"], :accounted => false)
            fb_run.save!
          rescue
            User.log_user_run self, run
          end
        end
      end
    end 
    self.update_attribute(:last_facebook_run, Time.now)
  end

  def query_tw
    begin
      ut = Twitter::Client.new(
        :oauth_token => self.oauth_token,
        :oauth_token_secret => self.oauth_token_secret,
        :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
        :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'])
      return ut.user_timeline(self.twitter_id.to_i, {:count => 200, :since_id => self.last_twitt_id.to_i})
    rescue => error
      if error.message == "Invalid or expired token"
        self.update_attributes({:oauth_token => nil, :oauth_token_secret => nil})
        User.log_parse_error "User #{self.id} without invalid TW token, needs to log back in"
      else
        User.log_error self, error
      end
      return nil
    end
  end

  def save_tw_runs
    twitts = self.query_tw
    if twitts
      twitts.each do |twitt|
        begin
          if twitt.attrs[:text].index("#nikeplus") and twitt.attrs[:text].index("http")
            original_url = /(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/.match(twitt.attrs[:text])[1]
            final_url = open(original_url, :allow_redirections => :all).base_uri.path
            if not Run.find_by_run_id(final_url.split("/").last)
              tw_run = Run.new(:user_id => self.id, :run_url => original_url, :run_id => final_url.split("/").last, :kilometers => distance_in_km_for_tw(twitt.attrs[:text].match("([0-9]*[.,][0-9]*[ ]*)(mi|km)")), :published_date => twitt.attrs[:created_at], :accounted => false)
              tw_run.save!
            end
          end
        rescue
          User.log_user_run self, twitt.to_yaml      
        end
      end
    end
    self.update_attribute(:last_twitt_id, twitts[0].id) if (twitts and not twitts.empty?)
  end

  def distance_in_km_for_fb distance_string
    distance = distance_string.split(" ")
    if distance[1] == "miles"
      return distance[0].to_f * MILE_TO_KM
    elsif distance[1] == "kilometers"
      return distance[0].to_f
    else
      User.log_parse_error "distance_string #{distance_string}"
      raise distance_string
    end
  end

  def distance_in_km_for_tw distance_exp
    if distance_exp[2] == "mi"
      return distance_exp[1].to_f * MILE_TO_KM
    else
      return distance_exp[1].to_f
    end
  end

  def save_total_kilometers
    km = 0
    self.runs.where("accounted != ?", true).each do |run|
      km += run.kilometers
      run.update_attribute(:accounted, true)
     end
    self.update_attribute(:kilometers, (self.kilometers || 0) + km.round(2))
  end

  def self.runs_logger
    @@runs_logger ||= Logger.new(File.join(Rails.root, 'log', 'runs_log.log'))
  end

  def self.log_user_run current_user, run
    begin
      User.runs_logger.error("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} user: #{current_user.id}, run: #{run}")
    rescue
      logger.error "The custom try_logger is not working."
    end
  end

  def self.log_parse_error error
    begin
      User.runs_logger.error("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} error: #{error}")
    rescue
      logger.error "The custom try_logger is not working."
    end
  end

  def self.log_error current_user, error
    begin
      User.runs_logger.error("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} user: #{current_user.id}, error: #{error}\n backtrace: #{error.backtrace}")
    rescue
      logger.error "The custom try_logger is not working."
    end
  end
end
