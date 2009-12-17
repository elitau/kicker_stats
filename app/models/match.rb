class Match < ActiveRecord::Base
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  has_many :teams, :dependent => :destroy
  has_many :players, :through => :teams
  
  default_scope :order => 'created_at'
  

  def team_player_names( winner_color )
    names = []
    @teams = Team.find(:all, :conditions => ["match_id=? AND team_color=?", self.id, winner_color])
    @teams.each do |team|
      names += [team.player.username]
    end
    return names.join(" und ")
  end
  
end
