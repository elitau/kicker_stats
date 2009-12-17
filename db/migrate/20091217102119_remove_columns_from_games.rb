class RemoveColumnsFromGames < ActiveRecord::Migration
  def self.up
    remove_column :games, :white_team_id
    remove_column :games, :yellow_team_id
  end

  def self.down
    add_column :games, :yellow_team_id, :integer
    add_column :games, :white_team_id, :integer
  end
end
