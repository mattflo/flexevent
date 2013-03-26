class Event < ActiveRecord::Base
  attr_accessible :address, :location, :name, :event_time, :voting_cutoff
  has_many :votes
  has_many :voters
end
