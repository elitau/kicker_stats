# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kicker_stats_session',
  :secret      => '126c1f4dd8c1c8ce1db31cb2030d4041357075dbd28aea1f978a0d7164643d4d9e27bbc4fc9f315cd4f26c134faa893192d8003dc4b5d6f018906572ddc27322'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
