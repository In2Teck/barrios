class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :picture_url_big, :picture_url_normal, :picture_url_thumb
  has_many :users

  def kilometers
    hood_total_km = 0
    self.users.each do |user|
      hood_total_km += user.kilometers
    end
    return hood_total_km
  end

  def self.total_kilometers
    hoods = Neighborhood.includes(:users)
    hoods.each do |hood| 
      hood["total_kilometers"] = hood.kilometers
    end
    return hoods 
  end

end
