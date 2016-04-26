require 'jumpstart_auth'
require 'bitly'

Bitly.use_api_version_3

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initiatializing MicroBlogger"
		@client = JumpstartAuth.twitter
	end

	def run
		puts "\n\tWelcome to the JSL Twitter Client, brought to you by JC\n\n"
		puts "Commands:\n\nQuit:\t\t\t\tq\nTweet:\t\t\t\tt my tweet"
		puts "Tweet w/ URL\t\t\tturl my tweet followed by www.longurlexample.com"
		puts "Direct Message:\t\t\tdm screenName my message"
		puts "SPAM followers\t\t\tspam 'my message'\nFriends Last Message\t\tfriends"
		puts "Shorten URL:\t\t\tsurl www.longwebsitename.come"
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
			when "q"
				puts "Later Aligator!"
			when "t"
				tweet(parts[1..-1].join(" "))
			when "dm"
				dm(parts[1], parts[2..-1].join(" "))
			when "spam"
				spam_my_followers(parts[1..-1].join(" "))
			when "friends"
				everyones_last_tweet
			when "surl"
				shorten(parts[1])
			when "turl"
				tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
			else
				puts "Sorry, the '#{command}' command is not known"
			end
		end
	end

	def tweet(message)
		if message.length.between?(1,140)
			@client.update(message)
			puts "\n...Tweeted sucessfully\n"
		elsif message.length > 140 || message.length == 0
			puts "\nERROR...A tweet has to be bewteen 1 & 140 characters"
		end
	end

	def dm(target, message)
		screen_names = @client.followers.map { |follower| @client.user(follower).screen_name }
		if screen_names.include?(target)
			puts "\n...Trying to send #{target} this direct message:"
			puts message
			message = "d @#{target} #{message}"
			tweet(message)
		else
			puts "\nERROR...You can only send Direct Messages to followers"
		end
	end

	def followers_list
		@client.followers.map { |follower| @client.user(follower).screen_name }
	end

	def spam_my_followers(message)
		followers = followers_list
		followers.each { |f| dm(f,message)}
	end

	def everyones_last_tweet
		friends = @client.friends.sort_by { |name| @client.user(name).screen_name.downcase }
		friends.each do |friend|
		 	last_message =  @client.user(friend).status
		 	timestamp = last_message.created_at.strftime("%A, %b %d") 
		 	puts "#{@client.user(friend).screen_name} said this on #{timestamp}... "
		 	puts "#{last_message.text}"
		 	puts ""
		 end
	end

	def shorten(original_url)
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end
end

blogger = MicroBlogger.new
blogger.run