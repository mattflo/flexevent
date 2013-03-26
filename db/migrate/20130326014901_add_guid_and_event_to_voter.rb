class AddGuidAndEventToVoter < ActiveRecord::Migration
  def change
  	add_column :voters, :event_id, :integer
  	add_column :voters, :guid, :string
  end
end
