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
  
  #TODO: refactor this richtung view helper
  def team_names
    matches.first.try(:team_names) || "???"
  end
  
  def winner_ids
    get_winner("ids")
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
  
  

  private

  def get_winner(mode)
    @matches = self.matches

    case self.best_of
      # Wenn es nur ein match in dem game gab, ist automatisch der match-winner
      # auch der game-winner
      when 1
        @match = @matches.first
        @match.team_player_names_or_ids_by_color(@match.match_winner, mode)
      # Wenn es 3 Gewinnmatches gibt, kann entweder schon nach 2 Matches oder nach 3 Matches
      # entschieden werden, wer der Game-Winner ist
      when 3
        # Diese Fallunterscheidung funktioniert nur bei einhaltung der Konvention, dass
        # nach jedem Match die Seiten gewechselt werden. Das Feld match-winner enthält
        # die farbe des match-winner-teams
        if @matches[0].match_winner != @matches[1].match_winner
          @matches[0].team_player_names_or_ids_by_color(@matches[0].match_winner, mode)
        # Wenn nach den ersten beiden matches kein gewinner ermittelt wurde ist automatisch
        # der match-winner des dritten matches der game-winner
        else
          @matches[2].team_player_names_or_ids_by_color(@matches[2].match_winner, mode)
        end
      else
        puts "The use of more than 3 matches is not implemented"
    end
  end


end
