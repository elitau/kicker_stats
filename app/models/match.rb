class Match < ActiveRecord::Base
  
  module PlayerExtension
    def usernames
      proxy_target.collect(&:username).join(", ")
    end
  end
  
  validates_presence_of :yellow_goals
  validates_presence_of :white_goals
  
  
  GOALS_TO_WIN = [6,10]
  
  belongs_to :game
  has_many :teams, :dependent => :destroy do
    def create_colored_team(player_ids, color)
      player_ids.each do |player_id|
        proxy_association.owner.teams.create(
          :team_color => color,
          :player_id => player_id
        )
      end
    end
  end
  has_many :players, :through => :teams, :extend => PlayerExtension do
    def usernames
      proxy_target.collect(&:username).join(", ")
    end
  end
  
  has_many :white_players, 
    :through    => :teams, 
    :source     => :player, 
    :conditions => ["teams.team_color = ?", "white"],
    # :order => "id",
    :extend => PlayerExtension

  has_many :yellow_players, 
    :through    => :teams, 
    :source     => :player, 
    :conditions => ["teams.team_color = ?", "yellow"],
    # :order => "id",
    :extend => PlayerExtension
    
  default_scope :order => 'created_at DESC'

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
  
  def goals_shot_by_player(player)
    if white_players.include?(player)
      white_goals
    elsif yellow_players.include?(player)
      yellow_goals
    else 
      return nil
    end
  end
  
  def goals_sucked_by_player(player)
    if white_players.include?(player)
      yellow_goals
    elsif yellow_players.include?(player)
      white_goals
    else 
      return nil
    end
  end

  def check_for_creep_and_twitter_it
    if white_goals == 0
      TwitterClient.update("#{white_players.collect(&:username).join(" und ")} ist gekrochen. HAR HAR HAR")
    elsif yellow_goals == 0
      TwitterClient.update("#{yellow_players.collect(&:username).join(" und ")} ist gekrochen. HAR HAR HAR")
    end
  end

end
