class Match < ActiveRecord::Base
  
  validates_presence_of :white_team_id
  validates_presence_of :yellow_team_id
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :white_team,  :class_name => "Team", :foreign_key => "white_team_id"
  belongs_to :yellow_team, :class_name => "Team", :foreign_key => "yellow_team_id"
  belongs_to :game
  
  default_scope :order => 'created_at'
  
  def winner
    if white_team and yellow_team
      if white_goals > yellow_goals
        return white_team
      else
        return yellow_team
      end
    else
      puts "uh oh"
      return nil
    end
  end
  
end
