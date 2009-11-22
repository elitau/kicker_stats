class Player < ActiveRecord::Base
  # acts_as_authentic
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_one :game
  has_many :teams
  
  def to_s
    username
  end
end
