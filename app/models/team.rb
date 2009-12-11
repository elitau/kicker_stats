class Team < ActiveRecord::Base

  # has_many :players, :through => :player_team
  # has_many :player_team, :class_name => "player_team"

  validates_presence_of :name
  
  has_and_belongs_to_many :players
  has_many :games
  
  named_scope :player_teams, lambda { |player_id|
   { :joins => :players, :conditions => ["player_id = ?", player_id] }
  }
  
  def usernames
    players.collect(&:username).join(', ')
  end
  
  # Die folgende Methode funktioniert nur mit maximalen 2 playern pro team
  # Und scheint irgendwie zu kompliziert gelöst :(
  def self.find_team_for_player_ids(player_ids)
    # player_ids könnte nils enthalten
    player_ids.compact!
    
    all_teams = player_ids.collect do |player_id|
      # gibt durch das named_scope ein array zurück
      Team.player_teams(player_id) 
    end
    
    return nil unless player_ids.size == all_teams.size
    players_team = case player_ids.size
      when 2
        all_teams[0] & all_teams[1]
      when 1
        # wenn nur eine id übergeben wurde, könnte der user in mehreren
        # teams sein. wir nehmen das team, das nur einen user enthält
        if (teams = all_teams[0]).size > 1
          teams.select{ |team| team.players.count == 1}
        else
          # wenn der user in keinem oder mehreren teams ist, muss ein neues
          # team mit NUR diesem user angelegt werden
          if !teams.empty? and teams.first.players.count > 1
            []
          else
            teams
          end
        end
      else
        []
    end
    
    return players_team.first
  end
  
  def self.find_or_create_team_for_player_ids(player_ids)
    if team = Team.find_team_for_player_ids(player_ids)
      return team
    else
      players = Player.find(player_ids)
      team = Team.new(:name => players.join(" und "))
      team.players = players
      team.save
      return team
    end
  end
  
end
