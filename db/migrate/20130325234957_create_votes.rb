class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.date :event_date
      t.integer :count
      t.integer :event_id

      t.timestamps
    end
  end
end
