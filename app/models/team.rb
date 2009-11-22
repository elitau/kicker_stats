class Team < ActiveRecord::Base
  has_and_belongs_to_many :players
  
  has_many :games
  
  def usernames
    players.collect(&:username).join(', ')
  end
end
