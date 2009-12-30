class Game < ActiveRecord::Base
  validates_inclusion_of :best_of, :in => [1,3],
                         :message => "{{value}} is not a valid option"

  has_many :matches, :dependent => :destroy do
    def create_match(params)
      match = proxy_owner.matches.build(
        :white_goals      => params[:white_goals],
        :yellow_goals     => params[:yellow_goals]
      )
      match.save
      match.teams.create_colored_team(params[:white_player_ids], "white")
      match.teams.create_colored_team(params[:yellow_player_ids], "yellow")
    end
  end
  
  def self.create_game_with_matches_and_teams(params)
    @game = Game.create(:best_of => params[:best_of])
    @game.matches.create_match(params)
    return @game
  end
  
  def winner?(player)
    winner_players.include?(player)
  end
  
  def winner_players
    if best_of == 1
      self.matches.first.winner_players
    else
      match_winner_players = self.matches.collect(&:winner_players)
      if match_winner_players[0] == match_winner_players[1]
        match_winner_players[0]
      else
        match_winner_players[2]
      end
    end
  end
  
  def single?
    self.matches.first.single?
  end
  
  def double?
    self.matches.first.double?
  end

end
