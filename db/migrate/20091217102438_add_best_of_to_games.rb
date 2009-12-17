class AddBestOfToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :best_of, :integer
  end

  def self.down
    remove_column :games, :best_of
  end
end
