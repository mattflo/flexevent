class Voter < ActiveRecord::Base
  attr_accessible :email, :vote_id
  belongs_to :vote
end
