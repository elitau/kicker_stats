class Player < ActiveRecord::Base
  # acts_as_authentic
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :teams, :dependent => :destroy
  has_many :matches, :through => :teams

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
  
end
