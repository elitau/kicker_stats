class RemoveIdFromPlayersTeams < ActiveRecord::Migration
  def self.up
    drop_table :players_teams
    create_table "players_teams", :force => true, :id => false do |t|
      t.integer  "player_id"
      t.integer  "team_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :players_teams
    create_table "players_teams", :force => true, :id => true do |t|
      t.integer  "player_id"
      t.integer  "team_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
