class DisplayController < ApplicationController

  #before_filter

	def index

	end

  def hood_select
    @hoods = Neighborhood.all
    rg = RestGraph.new(:access_token => current_user.access_token)
    @runs = rg.get('me/fitness.runs')
  end

  def twitter_share

  end

  def profile
    user_twitter = Twitter::Client.new(
      :oauth_token => current_user.oauth_token,
      :oauth_token_secret => current_user.oauth_token_secret,
      :consumer_key => ENV['TWITTER_CONSUMER_KEY'],
      :consumer_secret => ENV['TWITTER_CONSUMER_SECRET'])
    @twitts = user_twitter.user_timeline(current_user.twitter_id.to_i, {:count => 200, :since_id => current_user.first_twitt_id.to_i})
    #TODO: update current_user.first_twitt_id with @twitts[0].id
  end

  def hood_ranking

  end

  def hood_detail

  end
end
