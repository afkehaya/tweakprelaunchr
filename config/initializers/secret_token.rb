# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Prelaunchr::Application.config.secret_token = ENV["RAILS_SECRET"] || 'cd57fabf682957b005de7afd927f5b6eb5c78f92c05a539fdea6cae5aa9fe2b9d83964ff07bea10717d887b53578538df410a7ff8104d2b9b4ed794e4b57454f'