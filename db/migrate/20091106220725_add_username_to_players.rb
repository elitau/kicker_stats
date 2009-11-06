class AddUsernameToPlayers < ActiveRecord::Migration
  def self.up
    rename_column :players, :name, :username
    add_column :players, :firstname, :string
    add_column :players, :lastname, :string
  end

  def self.down
    remove_column :players, :lastname
    rename_column :players, :username, :name
    remove_column :players, :name
  end
end
