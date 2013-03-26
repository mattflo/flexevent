class Voter < ActiveRecord::Base
  attr_accessible :email, :vote_id, :event_id
  belongs_to :vote
  belongs_to :event
end
