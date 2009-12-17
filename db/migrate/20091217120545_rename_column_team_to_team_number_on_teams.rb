class RenameColumnTeamToTeamNumberOnTeams < ActiveRecord::Migration
  def self.up
    rename_column :teams, :team, :team_number
  end

  def self.down
    rename_column :teams, :team_number, :team
  end
end
