class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|
      t.string :email
      t.integer :vote_id

      t.timestamps
    end
  end
end
