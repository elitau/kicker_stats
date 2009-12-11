class Game < ActiveRecord::Base
  validates_presence_of :white_team_id
  validates_presence_of :yellow_team_id
  
  has_many :matches, :dependent => :destroy
  
  # TODO: Das hier ist falsch: Ein Spiel sollte ein team haben, das mal weiss mal
  # gelb ist. die farbe ändert sich ja pro match nicht pro spiel. also
  # vielleicht farbe dahin schieben oder die farbe als assoziation zw. team und match legen. z.B. has
  # many through
  belongs_to :white_team,  :class_name => "Team", :foreign_key => "white_team_id"
  belongs_to :yellow_team, :class_name => "Team", :foreign_key => "yellow_team_id"
  
  def winner
    nil
  end
  
  def self.create_with_teams(white_player_ids, yellow_player_ids)
    white_team = Team.find_or_create_team_for_player_ids(white_player_ids)
    yellow_team = Team.find_or_create_team_for_player_ids(yellow_player_ids)
    game = Game.create(:white_team => white_team, :yellow_team => yellow_team)
    return game 
  end
  
end
