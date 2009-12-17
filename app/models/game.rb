class Game < ActiveRecord::Base

  has_many :matches, :dependent => :destroy
  
  def winner
    nil
  end
  
  def self.create_with_teams(white_player_ids, yellow_player_ids)
    white_team = Team.find_or_create_team_for_player_ids(white_player_ids)
    yellow_team = Team.find_or_create_team_for_player_ids(yellow_player_ids)
    game = Game.create(:white_team => white_team, :yellow_team => yellow_team)
    return game 
  end
  
end
