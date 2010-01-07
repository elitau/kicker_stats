class Player < ActiveRecord::Base
  # acts_as_authentic
  
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
  
  def all_winning_matches
    matches.select do |match|
      match.winner?(self)
    end
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
