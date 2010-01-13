class Player < ActiveRecord::Base
  # acts_as_authentic
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "90x90>", :small => "20x20" }
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :teams, :dependent => :destroy
  has_many :matches, :through => :teams
  
  def to_s
    username
  end
  
  def full_name
    [firstname, lastname].compact.join(' ')
  end
  
  def weekly_statistics
    Statistic.create_weekly_statistics_for(self)
  end
  
  # goal_shot
  def goals_shot
    matches.inject(0) do |memo, match|
      memo + match.goals_shot_by_player(self)
    end
  end
  
  # tore, die man rein bekommen hat
  def sucked_goals
    matches.inject(0) do |memo, match|
      memo + match.goals_sucked_by_player(self)
    end
  end
  
  def goals_ratio
    goals_shot - sucked_goals
  end
  
  def all_winning_matches
    matches.select do |match|
      match.winner?(self)
    end
  end
  
  def all_lost_matches
    matches - all_winning_matches
  end
  
  def single_winning_matches
    all_winning_matches.select(&:single?)
  end
    
  def double_winning_matches
    all_winning_matches.select do |match|
      match.double?
    end
  end
  
  def all_winning_games
    all_games.select do |game|
      game.winner?(self)
    end
  end
  
  def single_winning_games
    all_winning_games.select do |game|
      game.single?
    end
  end
  
  def double_winning_games
    all_winning_games.select do |game|
      game.double?
    end
  end
  
  def all_lost_games
    all_games - all_winning_games
  end
  
  def all_games
    @games ||= games_from_matches(self.matches)
  end
  
  def <=>(other_player)
    self.username <=> other_player.username
  end
  
  def games_from_matches(matches)
    matches.collect do |match|
      match.game
    end.uniq
  end
  
end
