class AddEventStuff < ActiveRecord::Migration
  def up
  	add_column :events, :event_time, :time
  	add_column :events, :voting_cutoff, :timestamp
  end

  def down
  end
end
