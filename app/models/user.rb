class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :twitter_id, :first_name, :last_name, :roles, :access_token, :oauth_token, :oauth_token_secret, :facebook_hash, :twitter_hash, :first_twitt_id

  has_and_belongs_to_many :roles
  has_many :runs
  has_many :facebook_runs
  has_many :twitter_runs
  belongs_to :neighborhood

  #validates_presence_of :email, :password

	def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
		user = User.where(:email => auth.info.email).first
		unless user
			# CHECK FOR NEW/CREATE
			user = User.create(first_name:auth.info.first_name, last_name:auth.info.last_name, facebook_id:auth.uid, email:auth.info.email, password:Devise.friendly_token[0,20], access_token:auth.credentials.token, facebook_hash:auth)
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

			signed_in_resource.update_attributes({:twitter_id => auth_hash.uid, :oauth_token => auth_hash.credentials.token, :oauth_token_secret => auth_hash.credentials.secret, :twitter_hash => auth_hash, :first_twitt_id => last_twitt_id})
		end
		user || signed_in_resource
	end 

	def role?(role)
		return !!self.roles.find_by_name(role)
	end
end
