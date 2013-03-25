class Vote < ActiveRecord::Base
  attr_accessible :count, :event_date, :event_id
  belongs_to :event
end
