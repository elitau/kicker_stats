module GamesHelper
  
  def show_names_of_players(players)
    return "Nobody" unless players
    players.collect(&:username).join(", ")
  end

  def show_names_of_game_players(match)
    [show_names_of_players(match.white_players),
     show_names_of_players(match.yellow_players)].join(" vs. ")
  end

  def show_names_of_players_by_ids(player_ids)
    team_players = Team.team_players(player_ids)
    show_names_of_players(team_players)
  end
end
