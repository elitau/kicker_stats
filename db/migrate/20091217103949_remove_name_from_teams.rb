class RemoveNameFromTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :name
  end

  def self.down
    add_column :teams, :name, :string
  end
end
