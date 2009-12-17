class Player < ActiveRecord::Base
  # acts_as_authentic
  
  validates_uniqueness_of :username
  validates_presence_of :username

  has_many :teams, :dependent => :destroy
  has_many :matches, :through => :teams
  
  def to_s
    username
  end
  
end
