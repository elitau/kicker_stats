class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams, :force => true do |t|
      t.string :name
      t.timestamps
    end
    create_table :players_teams, :force => true do |t|
      t.integer :player_id
      t.integer :team_id
      t.timestamps
    end
  end

  def self.down
    drop_table :players_teams
    drop_table :teams
  end
end
