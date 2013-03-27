class Event < ActiveRecord::Base
  attr_accessible :address, :location, :name, :event_time, :voting_cutoff
  has_many :votes
  has_many :voters
  def voting_cutoff_clean
  	self.voting_cutoff.getlocal.strftime('%A %B %e %l:%M%p %Y %Z')
  end
end
