class MatchesBelongsToTeams < ActiveRecord::Migration
  def self.up
    rename_column :matches, :white_player_id, :white_team_id
    rename_column :matches, :yellow_player_id, :yellow_team_id
  end

  def self.down
    rename_column :matches, :yellow_team_id, :yellow_player_id
    rename_column :matches, :white_team_id, :white_player_id
  end
end
