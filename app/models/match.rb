class Match < ActiveRecord::Base
  
  validates_presence_of :white_player_id
  validates_presence_of :yellow_player_id
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :white_player,  :class_name => "Player", :foreign_key => "white_player_id"
  belongs_to :yellow_player, :class_name => "Player", :foreign_key => "yellow_player_id"
  belongs_to :game
  
  default_scope :order => 'created_at'
  
  def winner
    if white_player and yellow_player
      if white_goals > yellow_goals
        return white_player
      else
        return yellow_player
      end
    else
      puts "uh oh"
      return nil
    end
  end
  
end
