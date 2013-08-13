class Neighborhood < ActiveRecord::Base
  attr_accessible :name, :picture_url_big, :picture_url_normal, :picture_url_thumb
  has_many :users

end
