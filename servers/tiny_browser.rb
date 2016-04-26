require 'socket'
require 'json'

@user_agent = ["User-Agent: RubyCommandLine/1.0"]

def send_request(status_line, headers, message="")
	puts "\n\n\n"
	request = status_line + "\r\n" + headers.join("\r\n") + "\r\n\r\n" + message
	host = 'localhost'
	port = 3000
	socket = TCPSocket.open(host,port)
	socket.print(request)
	response = socket.read
	head,body = response.split("\r\n\r\n", 2)
	puts head
	puts body
end
 
def get_file(path)
	request = "GET #{path} HTTP/1.0"
	send_request(request, @user_agent)
end

def post_data
	path = "thanks.html"
	puts "Register Viking for a Raid:"
	printf "Viking's Name:"
	name_input = gets.chomp
	printf "Viking's email:"
	email_input = gets.chomp
	data = {:viking => {:name => name_input, :email => email_input}}.to_json
	status_line = "POST #{path} HTTP/1.0"
	type_header = "Content-Type: application/json"
	size_header = "Content-Length: " + data.size.to_s
	send_request(status_line, [@user_agent, type_header, size_header], data)
end

browser_open = true
while browser_open
	puts "\n\nCommand List:"
	puts "GET file\t\tget some_file.html"
	puts "POST data\t\tpost"
	puts "Close browser\t\tq"
	input = gets.chomp.downcase.split(" ")
	case input[0]
	when "get"
		get_file(input[1])
	when "post"
		post_data
	when "q"
		browser_open = false
	else
		puts "ERROR...invalid command"
	end
end
