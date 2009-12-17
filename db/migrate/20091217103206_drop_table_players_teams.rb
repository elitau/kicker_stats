class DropTablePlayersTeams < ActiveRecord::Migration
  def self.up
    drop_table :players_teams
  end

  def self.down
    create_table :players_teams, :force => true do |t|
      t.integer :player_id
      t.integer :team_id
      t.timestamps
    end
  end
end
