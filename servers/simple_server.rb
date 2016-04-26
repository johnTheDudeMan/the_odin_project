require 'socket'
require 'json'

server = TCPServer.open(3000)

def content_type(request)
	extension = File.extname(request[0][1])
	file_type = ""
	case extension
	when ".html"
		file_type = "text/html"
	end
	return "Content-Type: " + file_type
end

def process_request(request)
	request[0] = request[0].split
	if File.exist?(request[0][1])
		status_line = "HTTP/1.0 200 OK"
		header_type = content_type(request)
		header_length = "Content-Length: " + File.size(request[0][1]).to_s
		message = File.read(request[0][1])
		case request[0][0]
		when "GET"
			response(status_line, message, header_type, header_length)
		when "POST"
			params = JSON.parse(request.last)
			dynamic_message = message.sub("<%= yield %>", "<li>Name: #{params["viking"]["name"]}</li><li>Email: #{params["viking"]["email"]}</li>")
			response(status_line, dynamic_message, header_type, header_length)
		end
	else
		status_line = "HTTP/1.0 404 File NOT Found"
		message = "ERROR 404 - The file does not exist"
		response(status_line, message)
	end
end

def response(status_line, message="", *headers)
	header_age = "Date: " + Time.now.ctime
	return status_line + "\r\n" + header_age + "\r\n" + headers.join("\r\n") + "\r\n\r\n" + message
end

loop do
  Thread.start(server.accept) do |client|
  	request = client.recv(1000).split("\r\n")
  	p request
  	client.puts process_request(request)
    client.close 
  end
end
