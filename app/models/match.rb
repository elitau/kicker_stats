class Match < ActiveRecord::Base
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  has_many :teams, :dependent => :destroy
  has_many :players, :through => :teams
  
  default_scope :order => 'created_at'
  
  def self.create_match(game_id, white_goals, yellow_goals)
    match_winner = calculate_match_winner(white_goals, yellow_goals)
    match = Match.create(:game_id => game_id,
                         :white_goals => white_goals,
                         :yellow_goals => yellow_goals,
                         :match_winner => match_winner )
    return match
  end

  def self.calculate_match_winner(white_goals, yellow_goals)
     case white_goals<yellow_goals
       when true
         "yellow"
       when false
         "white"
     end
  end

  def find_or_create_teams(white_player_ids, yellow_player_ids)
    Team.create_team(white_player_ids, self.id, "white")
    Team.create_team(yellow_player_ids, self.id, "yellow")
  end

  # TODO in team gibt es eine ähnliche methode die auch namen zurückgibt, aber gänzlich
  # anders arbeitet. Man sollte versuchen diese beiden zu vereinen
  def team_player_names_or_ids_by_color( color, mode )
    names_or_ids = []
    @teams = Team.all(:conditions => ["match_id=? AND team_color=?", self.id, color])
    @teams.each do |team|
      if mode.eql?("names")
        names_or_ids += [team.player.username]
      elsif mode.eql?("ids")
        names_or_ids += [team.player.id]
      end
    end
    names_or_ids = names_or_ids.join(" und ") if mode.eql?("names")
    return names_or_ids
  end

end
