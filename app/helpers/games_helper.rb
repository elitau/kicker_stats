module GamesHelper
  
  def show_names_of_team_players(players)
    players.collect(&:username).join(", ")
  end

  def show_names_of_game_players(match)
    [show_names_of_team_players(match.white_players),
     show_names_of_team_players(match.yellow_players)].join(" vs. ")
  end  
end
