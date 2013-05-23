class Vote < ActiveRecord::Base
  attr_accessible :count, :event_date, :event_id, :upvoted, :downvoted
  belongs_to :event
  has_many :voters
  has_many :ballots
  def downvotes
    ballot_summation -1
  end
  def upvotes
    ballot_summation 1
  end
  def ballot_summation direction
    ballots.select{|b| b.direction == direction}.sum {|b| b.direction}
  end
  def contextify voter
    @ballot = voter.ballots.find {|b| b.vote == self}
  	@upvoted = voter.ballots.any? {|b| b.vote == self and b.direction == 1}
  	@downvoted = voter.ballots.any? {|b| b.vote == self and b.direction == -1}
  end
  def as_json(options = { })
    options[:except] = [:created_at, :updated_at]
    h = super(options)
    h[:upvoted]   = @upvoted
    h[:downvoted] = @downvoted
    h[:ballot] = @ballot.as_json options if @ballot
    h
  end
end
