class Team < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :match

  def self.all_teams
    matches = Match.all
    teams = matches.collect do |match|
      match.yellow_players.collect do |player|
        player.id
      end
    end
    teams += matches.collect do |match|
      match.white_players.collect do |player|
        player.id
      end
    end

    teams.uniq
  end

  def self.team_wins(player_ids)
    count = 0
    Game.all.each do |game|
      if game.winner_players.eql? Team.team_players(player_ids)
        count += 1
      end
    end
    return count
  end

  def self.team_players(player_ids)
    players = player_ids.collect do |player_id|
      Player.find(player_id)
    end
    return players
  end
  
end
