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
    :conditions => ["teams.team_color = ?", "white"],
    :order => "id"

  has_many :yellow_players, 
    :through    => :teams, 
    :source     => :player, 
    :conditions => ["teams.team_color = ?", "yellow"],
    :order => "id"
    
  
  default_scope :order => 'created_at'

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
