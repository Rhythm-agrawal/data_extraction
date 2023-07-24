require_relative "api_app"

# Run the API using Rack
Rack::Handler::WEBrick.run APIApp, Port: 3000 if $PROGRAM_NAME == __FILE__
