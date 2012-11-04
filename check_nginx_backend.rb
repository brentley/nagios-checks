#!/usr/bin/env ruby

require 'nokogiri'
require 'pp'
require 'open-uri'

downservers = Array.new
doc = Nokogiri::HTML(open("http://#{ARGV}/backend-status/"))

doc.css("tr")[1..-2].each do |tr|
  status = tr.css('td').map{ |td|  
      td.text.gsub(/[$,](?=\d)/, '').gsub(/\302\240|\s/, ' ').strip
   }.join("|").split("|")

	if not status[8].eql? "0"
  		downservers << "#{status[1].split(":")[0]} "
	end   

end

if downservers.count > 1
	puts "Backend Webs Down: #{downservers}"
	exit 2
elsif downservers.count == 1
	puts "Backend Web Down: #{downservers}"
	exit 1
elsif downservers.count == 0
 	puts "All Backend Webs Okay"
	exit 0
end

