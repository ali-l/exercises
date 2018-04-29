require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

class Request
  attr_reader :lines, :filename, :filetype, :socket

  def initialize(socket)
    @socket = socket
  end

  def parse
    @lines = []
    while (line = @socket.gets)  # Read the request and collect it until it's empty
      line = line.chomp
      break if line.empty?
      @lines << line
    end
  end

  def get_filename
    @filename = @lines[0].gsub(/GET \//, "").gsub(/ HTTP.*/, "")

    if @filename == ""
      @filename = "index.html"
    end
  end

  def get_filetype
    if @filename =~ /.css/
      @filetype = "text/css"
    elsif @filename =~ /.html/
      @filetype = "text/html"
    else
      @filetype = "text/plain"
    end
  end
end

class Response
  attr_reader :response

  def initialize(socket)
    @socket = socket
  end 

  def make(request)
    headers = []

    if File.exists?(request.filename)
      body = File.read(request.filename)
      headers << "HTTP/1.1 200 OK"
      headers << "Content-type: #{request.filetype}"
    else
      body = "File not found\n"
      headers << "HTTP/1.1 404 Not Found"
      headers << "Content-type: text/plain"
    end

    headers << "Content-length: #{body.size}"
    headers << "Connection: close"
  
    headers = headers.join("\r\n")
    @response = [headers, body].join("\r\n\r\n")
  end
end

class Server
  def initialize(host = 'localhost', port = 2000)
    @host = host
    @port = port
  end

  def run
    @server = TCPServer.open(@host, @port)
    puts "Server started on #{@host}:#{@port} ..."
    loop do                                             # Server runs forever
      socket = @server.accept
      request = Request.new(socket)                            # Wait for a request to connect. Accept returns a TCPSocket                                       # Output the full request to stdout
      request.parse
      request.get_filename
      request.get_filetype
      puts request.lines

      if request.lines.empty?
         puts "Nil request"
         next
      end
      
      puts request.filename

      response = Response.new(socket)

      socket.puts(response.make(request))                       # Output the current time to the request
      socket.close                                      # Disconnect from the request
    end
  end 
end

my_server = Server.new
my_server.run