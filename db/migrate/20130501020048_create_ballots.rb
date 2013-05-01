class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.integer :direction
      t.references :voter
      t.references :vote

      t.timestamps
    end
    add_index :ballots, :voter_id
    add_index :ballots, :vote_id
  end
end
