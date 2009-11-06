class Player < ActiveRecord::Base
  acts_as_authentic
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_one :game
end
