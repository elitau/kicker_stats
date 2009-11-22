class Game < ActiveRecord::Base
  validates_presence_of :white_team_id
  validates_presence_of :yellow_team_id
  
  has_many :matches
  belongs_to :white_team,  :class_name => "Team", :foreign_key => "white_team_id"
  belongs_to :yellow_team, :class_name => "Team", :foreign_key => "yellow_team_id"
  
  def winner
    nil
  end
  
end
