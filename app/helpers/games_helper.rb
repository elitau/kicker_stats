module GamesHelper
  
  def show_names_of_players(players)
    players.collect(&:username).join(", ")
  end
  
end
