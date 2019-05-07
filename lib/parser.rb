require 'forwardable'
require 'set'

# Log holds data of a single log entry
Log = Struct.new(:url, :ip)


# LogParser is a class reading simple access log and computing unique visits
class LogParser
  include Enumerable

  # Expose log entries under LogParser instance without having to dig into @logs attribute
  extend Forwardable
  def_delegators :@logs, :each, :<<, :empty?, :size, :[]

  # Creates new LogParser to later read given filename
  # @param filename [String] File to read
  def initialize(filename)
    @filename = filename
    # log_format: url(without spaces) followed by ip
    @log_format = /^(?<url>[^ ]+) (?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})$/
    @logs = []
    @logs_unique = nil
  end

  # Read all the logs
  def call
    @logs = []
    @logs_unique = nil
    File.foreach(@filename) do |line|
      if m = line.match(@log_format)
        @logs.push Log.new(*m.captures)
      else
        raise Error, "Unmatched lines: #{line}"
      end
    end
  end

  # Return unique views for each URL
  #
  # Unique views are not computed until you ask for them
  # Computed results are cached
  #
  # @return [Hash] mapping URLs to unique view count
  def unique
    return @logs_unique unless @logs_unique.nil?

    # Store unique IPs
    @logs_unique = {}
    @logs.each do |log|
      if @logs_unique.has_key? log.url
        @logs_unique[log.url].add(log.ip)
      else
        @logs_unique[log.url] = Set.new([log.ip])
      end
    end

    # Count unique IPs
    @logs_unique.each {|url, ip_set| @logs_unique[url] = ip_set.size}

    # Inject order method if someone wants to get ordered results
    # TODO ideally it should have the same return type as `unique`
    def @logs_unique.order(direction)
      direction = direction[:views] || :desc
      arr = sort_by {|url, views| views}

      direction == :asc ? arr : arr.reverse
    end

    @logs_unique
  end
end
