class Player < ActiveRecord::Base
  validates_uniqueness_of :name
  has_one :game
end
