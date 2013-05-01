class Ballot < ActiveRecord::Base
  belongs_to :voter
  belongs_to :vote
  attr_accessible :direction
end
