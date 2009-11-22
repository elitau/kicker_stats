class Match < ActiveRecord::Base
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  
  default_scope :order => 'created_at'
  
  def yellow_team
    game.yellow_team
  end
  
  def white_team
    game.white_team
  end
  
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
