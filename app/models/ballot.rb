class Ballot < ActiveRecord::Base
  belongs_to :voter
  belongs_to :vote
  attr_accessible :direction

  def as_json options ={}
    options[:except] = [:created_at, :updated_at, :voter_id, :vote_id, :id]
    h = super(options)
    h[:voter] = options[:voter]
    h
  end
end
