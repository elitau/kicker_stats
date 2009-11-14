# Be sure to restart your server when you modify this file.
 
# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kicker_stats_session',
  :secret      => 'ca730d1f3a19c941005a744bb9bedaad3d4e2d23e8d09d7b4b39e0ab1b708712e08aa61c7ddcf27cf5b618df1ee3c45a5a96d83a1441e6b4da99f0d17fe23716'
}
 
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store