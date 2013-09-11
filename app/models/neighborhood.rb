class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :picture_url_big, :picture_url_normal, :picture_url_thumb
  has_many :users

  def stats
    total_stats = Neighborhood.where("picture_url_big is not null").total_stats.sort_by{|neigh| [-neigh.total_kilometers, -neigh.total_users]}
    position = total_stats.index(self)
    kilometers = total_stats[position]["total_kilometers"]
    users = total_stats[position]["total_users"]
    return {:kilometers => kilometers, :users => users, :position => (position + 1)}
  end

  def ind_stats
    hood_total_km = 0.0
    hood_total_users = 0
    self.users.each do |user|
      hood_total_km += user.kilometers
      hood_total_users += 1
    end
    return {:kilometers => hood_total_km.round(2), :users => hood_total_users}
  end
  
  def self.total_stats
    hoods = Neighborhood.includes(:users) 
    hoods.each do |hood| 
      stats = hood.ind_stats
      hood["total_kilometers"] = stats[:kilometers]
      hood["total_users"] = stats[:users]
    end
    return hoods
  end

end
