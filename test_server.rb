require 'socket'

server = TCPServer.new('localhost', 2345)

loop do
  socket = server.accept
  request = socket.gets
  STDERR.puts request
  output = 'Hello World'
  response = [
    "HTTP/1.1 200 OK",
    "Content-Type: text/plain",
    "Content-Length: #{output.bytesize}",
    "Connection: close",
    "",
    output
  ].join("\r\n")
  socket.print response



  # response =   "HTTP/1.1 200 OK\r\n" +
  #              "Content-Type: text/plain\r\n" +
  #              "Content-Length: #{output.bytesize}\r\n" +
  #              "Connection: close\r\n\r\n" +
  #              output
  # socket.print response
  # STDERR.puts response
  socket.close
end