class Player < ActiveRecord::Base
  # acts_as_authentic
  
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :teams, :dependent => :destroy
  has_many :matches, :through => :teams #, :order => "teams.created_at ASC"

  TOTAL = -1
  SINGLE = 1
  DOUBLE = 2
  
  def to_s
    username
  end
  
  def full_name
    [firstname, lastname].compact.join(' ')
  end

  def wins( teamsize )
    count = 0
    Game.all.each do |game|
      if game.winner_ids.include?(id)
        case teamsize
          when TOTAL
            count += 1
          when SINGLE
            if game.winner_ids.size == 1
              count += 1
            end
          when DOUBLE
            if game.winner_ids.size == 2
              count += 1
            end
          else
            puts "Too many ids per team"
        end
      end
    end
    return count
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
  
  def games_from_matches(matches)
    matches.collect do |match|
      match.game
    end.uniq
  end
  
end
