# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_pyynikki_session',
  :secret => 'e8fb685ab52fb1d3939078c02e77b5cef1a90a040d6376854bcd9a1c03de2d2d43febd0f41b3850e668dde5f584fa01f31d063314a7c4055fd05a0b833c6f05a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
