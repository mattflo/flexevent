class Voter < ActiveRecord::Base
  attr_accessible :email, :vote_id, :event_id
  belongs_to :vote
  belongs_to :event
  before_save :default_values
  def default_values
  	self.guid = SecureRandom.uuid
  end
  def email_scrubbed
  	return "" unless self.email
  	self.email[0,2] + '***@***' + self.email[-6,6] 
  end
end
