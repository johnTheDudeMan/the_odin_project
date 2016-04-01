require 'csv'
require 'sunlight/congress'
require 'erb'
require 'date'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zip)
	zip.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
	Sunlight::Congress::Legislator.by_zipcode(zip)
end

def save_thank_you_letters(id, form_letter)
	Dir.mkdir("output") unless Dir.exists?("output")
	filename = "output/thanks_#{id}.html"
	File.open(filename, 'w') {|f| f.puts form_letter}
end

def clean_phone_number(num)
	num = "" if num.nil?
	phone_num = num.split("").select {|e| e =~ /\d/}.join("")
	if phone_num.length == 10
		phone_num
	elsif phone_num.length == 11 && phone_num[0] == "1"
		phone_num[1..10]
	else
		""
	end
end



@date_time_registered = []
def to_date_and_time(regdate)
	date_time = DateTime.strptime(regdate, '%m/%d/%y %H:%M')
	@date_time_registered << date_time
	date_time
end

# top 3 peak hours is easier to see if peak time is 
# between the 30 min marks on the hour (IMO)
def peak_hours
	hours = Hash.new
	top_three = []
	(0..23).each {|e| hours[e.to_s] = 0}
	@date_time_registered.each {|e| hours[e.hour.to_s] += 1}
	3.times do
		top_three << hours.max_by {|k,v| v}
		hours[top_three.last[0]] = 0
	end
	puts "\nPeak Hours:"
	top_three.each {|e| puts "#{e[1]} registered on hour #{e[0]}:00"}
end

def popular_registration_days
	days = { sunday: 0, monday: 0, tuesday: 0, wednesday: 0, thursday: 0, friday: 0, saturday: 0 }
	(0..6).each 
	@date_time_registered.each do |e|
		case e.wday
		when 0
			days[:sunday] += 1
		when 1
			days[:monday] += 1
		when 2
			days[:tuesday] += 1
		when 3
			days[:wednesday] += 1
		when 4
			days[:thursday] += 1
		when 5
			days[:friday] += 1
		when 6
			days[:saturday] += 1
		end
	end
	puts "\nPeople Days:"
	days.sort_by {|k,v| v}.reverse.each {|k,v| puts "#{k.to_s.capitalize} - #{v}"}	
end

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
	id = row[0]
	reg_date = to_date_and_time(row[:regdate])
	name = row[:first_name]
	phone_number = clean_phone_number(row[:homephone])
	zipcode = clean_zipcode(row[:zipcode])
	legislators = legislators_by_zipcode(zipcode)
	puts "#{name}" #leaving this in because its fun to watch
	form_letter = erb_template.result(binding)
	save_thank_you_letters(id, form_letter)	
end

peak_hours
popular_registration_days






