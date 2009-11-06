class AddAuthenticationAttributesToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :email, :string
    add_column :players, :crypted_password, :string
    add_column :players, :password_salt, :string
    add_column :players, :persistence_token, :string
  end

  def self.down
    remove_column :players, :persistence_token
    remove_column :players, :password_salt
    remove_column :players, :crypted_password
    remove_column :players, :email
  end
end
