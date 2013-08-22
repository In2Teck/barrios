class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :picture_url_big, :picture_url_normal, :picture_url_thumb
  has_many :users

  def stats
    hood_total_km = 0.0
    hood_total_users = 0
    self.users.each do |user|
      hood_total_km += user.kilometers
      hood_total_users += 1
    end
    return {:kilometers => hood_total_km, :users => hood_total_users}
  end
  
  def self.total_stats
    hoods = Neighborhood.includes(:users) 
    hoods.each do |hood| 
      stats = hood.stats
      hood["total_kilometers"] = stats[:kilometers]
      hood["total_users"] = stats[:users]
    end
    return hoods
  end

end
