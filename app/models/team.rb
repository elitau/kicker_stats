class Team < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :match

  def usernames
    players.collect(&:username).join(', ')
  end

  def self.create_team(player_ids, match_id, team_color)
    team_number = find_team_number_for_player_ids(player_ids)
    # Falls es noch keine team_number gibt, wird eine neue einzigartige team_number erstellt
    if team_number.nil?
      team_number = Time.now.to_i + player_ids[0].to_i
    end
    player_ids.each_index do |p|
      Team.create(:player_id => player_ids[p],
                  :match_id => match_id,
                  :team_color => team_color,
                  :team_number => team_number)
    end
  end
  
  def self.find_team_number_for_player_ids(player_ids)
    # player_ids könnte nils enthalten
    player_ids.compact!

    # Generiert ein Array der Größe player_ids.size von Team_number-Arrays Bsp. [[1,3],[1,4]]
    all_team_numbers = player_ids.collect do |player_id|
      get_team_numbers_for_teams(Team.all(:conditions => ["player_id = ?", player_id],
                                               :select => "DISTINCT(team_number)"))
    end

    return nil unless player_ids.size == all_team_numbers.size

    players_team = case player_ids.size
      when 2
        all_team_numbers[0] & all_team_numbers[1]
      when 1
        all_team_numbers[0].select{ |team_number| single?(team_number) }
      else
        []
    end
    return players_team.first unless players_team.first.nil?
  end

  def self.get_team_numbers_for_teams(teams)
    team_numbers = teams.collect do |team|
      team.team_number
    end
    return team_numbers
  end
  
  def self.single?(team_number)
    if Team.all(:conditions => ["team_number = ?", team_number],
             :select => "DISTINCT(player_id)").size == 1
      return true
    else
      return false
    end
  end
  
end
