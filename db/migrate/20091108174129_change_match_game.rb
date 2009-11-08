class ChangeMatchGame < ActiveRecord::Migration
  def self.up
    add_column :matches, :white_player_id, :integer
    add_column :matches, :yellow_player_id, :integer
    add_column :matches, :yellow_goals, :integer
    add_column :matches, :white_goals, :integer
    add_column :matches, :goals_to_win, :integer
    
    remove_column :games, :white_player_id
    remove_column :games, :yellow_player_id
    remove_column :games, :white_goals
    remove_column :games, :yellow_goals
    remove_column :games, :goals_to_win
  end

  def self.down
    remove_column :matches, :goals_to_win
    remove_column :matches, :white_goals
    remove_column :matches, :yellow_goals
    remove_column :matches, :yellow_player_id
    remove_column :matches, :white_player_id

    add_column :games, :goals_to_win, :integer
    add_column :games, :yellow_goals, :integer
    add_column :games, :white_goals, :integer
    add_column :games, :yellow_player_id, :integer
    add_column :games, :white_player_id, :integer
  end
end
