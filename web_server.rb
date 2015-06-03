require 'socket'

class WebServer
  attr_accessor :host, :port

  def initialize(app, attrs={})
    @app = app
    @host = attrs.fetch(:host, 'localhost')
    @port = attrs.fetch(:port, 2345)
    @server = TCPServer.new(@host, @port)
  end

  def run
    begin
      puts "You start webserver on http://#{@host}:#{@port}. Press ctrl-C for exit."
      loop do
        socket = @server.accept
        request = socket.gets
        socket.print(perform_app({request: request}))
        socket.close
      end
    rescue Interrupt => e
      puts "\nServer was stopped."
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