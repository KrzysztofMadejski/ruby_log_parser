#!/usr/bin/env ruby


# TODO parse initial arguments
file = 'webserver.log'

class LogParser
  def initialize(file)
    @file_stream = file
  end

  def parse
    
  end

  def unique
    []
  end
end

# TODO open
logs = LogParser.new(file)
logs.parse # TODO parse here or while creating?

logs.unique.order(:views).each do |visit|
  puts "#{visit.url} #{visit.count}}" # TODO pluralize
end