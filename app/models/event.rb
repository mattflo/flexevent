class Event < ActiveRecord::Base
  attr_accessible :address, :location, :name
  has_many :votes
end
