class RemoveTeamNumberFromTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :team_number
  end

  def self.down
    add_column :teams, :team_number, :integer
  end
end
