require 'web_server.rb'
require 'application.rb'

app = Application.new
server = WebServer.new(app)
server.run