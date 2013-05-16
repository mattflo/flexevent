class Vote < ActiveRecord::Base
  attr_accessible :count, :event_date, :event_id, :upvoted, :downvoted
  belongs_to :event
  has_many :voters
  has_many :ballots
  def downvotes
  	ballots.select{|b| b.direction == -1}.sum {|b| b.direction}
  end
  def upvotes
  	ballots.select{|b| b.direction == 1}.sum {|b| b.direction}
  end
  def contextify voter
  	@upvoted = voter.ballots.any? {|b| b.vote == self and b.direction == 1}
  	@downvoted = voter.ballots.any? {|b| b.vote == self and b.direction == -1}
  end
  def as_json(options = { })
    h = super(options)
    h[:upvoted]   = @upvoted
    h[:downvoted] = @downvoted
    h[:voter] = options[:voter]
    h
  end
end
