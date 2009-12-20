class Match < ActiveRecord::Base
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  has_many :teams, :dependent => :destroy
  has_many :players, :through => :teams
  
  default_scope :order => 'created_at'
  

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
    return names_or_ids
  end

end
