class Game < ActiveRecord::Base
  has_many :matches
  def winner
    nil
  end
  
end
