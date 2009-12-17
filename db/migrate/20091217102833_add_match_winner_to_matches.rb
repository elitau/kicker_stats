class AddMatchWinnerToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :match_winner, :string
  end

  def self.down
    remove_column :matches, :match_winner
  end
end
