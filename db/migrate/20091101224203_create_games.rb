class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :white_player_id
      t.integer :yellow_player_id
      t.integer :white_goals
      t.integer :yellow_goals
      t.integer :goals_to_win

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
