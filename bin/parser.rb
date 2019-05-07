#!/usr/bin/env ruby

require "./lib/parser.rb"

filename = ARGV.first

unless filename
  puts "Please provide logfile as the first argument"

  exit(1)
end

logs = LogParser.new(filename)
logs.call

# puts "All entries: "
# logs.each do |visit|
#   puts "#{visit.url} #{visit.ip}"
# end

logs.unique.order(views: :desc).each do |url, count|
  puts "#{url} #{count} unique " + "view" + (count != 1 ? "s" : "")
end
