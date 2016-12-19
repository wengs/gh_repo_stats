require 'open-uri'
require 'zlib'
require 'yajl'
require_relative 'time_service'

class GithubArchiveStats
  include TimeService

  attr_reader :data

  def initialize(after_time, before_time, event_type, count, base_url="http://data.githubarchive.org/")
    @after_time = datetime_to_utc(after_time)
    @before_time = datetime_to_utc(before_time)
    @event_type = event_type
    @base_url = base_url
    @count = count
    @data = {}
  end

  def parse_events
    # parse data from Github archive API
    print "Parsing"
    data = {}.tap do |hash|
      date_time = DateTime.parse(@after_time.strftime("%Y-%m-%d %k:00"))
      count = 0
      while (date_time < @before_time) do
        print '.'
        url = @base_url + gh_file_name_for_specified_hour(date_time) + ".json.gz"
        gz = open(url)
        js = Zlib::GzipReader.new(gz).read
        Yajl::Parser.parse(js) do |event|
          event_type = event["type"]
          event_time = DateTime.parse(event["created_at"])

          if record_event?(event, event_type, event_time, @after_time, @before_time)
            name = repo_name event
            hash[name] = 0 unless hash[name]
            hash[name] += 1
          end
        end

        date_time += (1/24.0)
      end
    end

    @data = data.sort_by {|k,v| v}.reverse.first(@count)
  end

  def print_events
    # ouput the parsed data from #parse_events
    @data.each { |repo, events_count| puts output_format(repo, events_count) }
  end

  def gh_file_name_for_specified_hour(date_time)
    # format time to Github Archive acceptable format
    date_time.strftime("%Y-%m-%d-%k").gsub(/\s+/, "")
  end

  private
  def record_event?(event, event_type, event_time, after_time, before_time)
    event.has_key?('repository') &&
    correct_event_type?(event_type) &&
    within_time_range?(event_time, after_time, before_time)
  end

  def event_with_repo?(event)
    # check if this event is involved with repo
    event.has_key? 'repository'
  end

  def repo_name(event)
    # repo_url.gsub(/http[s]?:\/\/github.com\//,'')
    repo = event['repository']
    [repo['owner'], repo['name']].join("/")
  end

  def output_format(repo, events_count)
    [repo, "#{events_count} events"].join(" - ")
  end

  def correct_event_type?(type)
    type == @event_type
  end

  def date_range_output(after, before)
    [date(after), date(before)].join("..")
  end

  def hour_range_output(after, before)
    [hour(after), hour(before)].join("..")
  end
end