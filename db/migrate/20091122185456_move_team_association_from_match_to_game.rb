class MoveTeamAssociationFromMatchToGame < ActiveRecord::Migration
  def self.up
    remove_column :matches, :white_team_id
    remove_column :matches, :yellow_team_id
    
    add_column :games, :white_team_id, :integer
    add_column :games, :yellow_team_id, :integer
  end

  def self.down
    add_column :matches, :white_team_id, :integer
    add_column :matches, :yellow_team_id, :integer
    remove_column :games, :white_team_id
    remove_column :games, :yellow_team_id
  end
end
