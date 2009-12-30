class RemoveMatchWinnerFromMatches < ActiveRecord::Migration
  def self.up
    remove_column :matches, :match_winner
  end

  def self.down
    add_column :matches, :match_winner, :string
  end
end
