class AddColumnsToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :player_id, :integer
    add_column :teams, :match_id, :integer
    add_column :teams, :team, :integer
    add_column :teams, :team_color, :string
  end

  def self.down
    remove_column :teams, :team_color
    remove_column :teams, :team
    remove_column :teams, :match_id
    remove_column :teams, :player_id
  end
end
