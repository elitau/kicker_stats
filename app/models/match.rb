class Match < ActiveRecord::Base
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  has_many :teams, :dependent => :destroy do
    def create_colored_team(player_ids, color)
      player_ids.each do |player_id|
        proxy_owner.teams.create(
          :team_color => color,
          :player_id => player_id
        )
      end
    end
  end
  has_many :players, :through => :teams
  
  has_many :white_players, 
    :through    => :teams, 
    :source     => :player, 
    :conditions => ["teams.team_color = ?", "white"]

  has_many :yellow_players, 
    :through    => :teams, 
    :source     => :player, 
    :conditions => ["teams.team_color = ?", "yellow"]
    
  
  default_scope :order => 'created_at'
  
  def team_names
    [
      white_players.collect(&:username).join(","),
      yellow_players.collect(&:username).join(",")
    ].join(" vs. ")
  end
  
  def self.create_match(game_id, white_goals, yellow_goals)
    # match_winner = calculate_match_winner(white_goals, yellow_goals)
    match = Match.create(:game_id => game_id,
                         :white_goals => white_goals,
                         :yellow_goals => yellow_goals )
    return match
  end

  def find_or_create_teams(white_player_ids, yellow_player_ids)
    # Team.create_team(white_player_ids, self.id, "white")
    # Team.create_team(yellow_player_ids, self.id, "yellow")
    self.white_players = Player.find(white_player_ids)
    self.yellow_players = Player.find(yellow_player_ids)
    self.save
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

  def winner_players
    if self.white_goals < self.yellow_goals
       self.yellow_players
     else
       self.white_players
    end
  end
  
  def winner?(player)
    self.winner_players.include?(player)
  end
  
  def single?
    self.white_players.count == 1
  end

  def double?
    self.white_players.count == 2
  end
  

end
