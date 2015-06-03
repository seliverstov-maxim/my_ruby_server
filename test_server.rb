require 'socket'

class WebServer
  attr_accessor :server, :host, :port

  def initialize(app, attrs={})
    @app = app
    @server = TCPServer.new(attrs.fetch(:host, 'localhost'), attrs.fetch(:port, 2345))
  end

  def run
    loop do
      socket = server.accept
      request = socket.gets
      socket.print(perform_app({request: request}))
      socket.close
    end
  end

  def perform_app(env={})
    STDERR.puts env[:request]
    app_response = @app.call(env)
    res= [
      "HTTP/1.1 #{app_response[0]}",
      "Content-Type: #{app_response[1]}",
      "Content-Length: #{app_response[2].bytesize}",
      "Connection: close",
      "",
      app_response[2]
    ].join("\r\n")
  end
end

server = WebServer.new proc{ [200, 'text/plain', 'Result'] }
server.run