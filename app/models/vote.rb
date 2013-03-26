class Vote < ActiveRecord::Base
  attr_accessible :count, :event_date, :event_id
  belongs_to :event
  has_many :voters
end
