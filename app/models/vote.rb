class Vote < ActiveRecord::Base
  attr_accessible :count, :event_date, :event_id
  belongs_to :event
  has_many :voters
  has_many :ballots
  def downvotes
  	ballots.select{|b| b.direction == -1}.sum {|b| b.direction}
  end
  def upvotes
  	ballots.select{|b| b.direction == 1}.sum {|b| b.direction}
  end
end
