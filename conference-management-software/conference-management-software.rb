require "time"

class Session
  attr_reader :talks
  attr_reader :available_time
  attr_reader :time

  MORNING_LENGTH = 180
  AFTERNOON_LENGTH = 240

  def initialize(period="morning")
    @talks = []
    if period.downcase == "afternoon"
      @time = Time.parse("13:00")
      @available_time = AFTERNOON_LENGTH
    else
      @time = Time.parse("09:00")
      @available_time = MORNING_LENGTH
    end
  end

  def has_space?(talk_length)
    @available_time >= talk_length
  end

  def add(title, length)
    @available_time -= length
    @talks << "#{schedule(length)} #{title} #{length_format(length)}"
  end

  private
  
    def schedule(length)
      format = format('%02d:%02d', @time.hour, @time.min)
      @time += (60 * length)
      format
    end

    def length_format(length)
      length == 5 ? "talk" : "minutes"
    end
end

class Track
  attr_reader :morning_sessions
  attr_reader :afternoon_sessions

  def initialize
    @morning_sessions   = Session.new("morning")
    @afternoon_sessions = Session.new("afternoon")
  end

  def insert_talks_on_track(talk_lists)
    talk_lists.each do |title, length|
      if @morning_sessions.has_space?(length)
        @morning_sessions.add(title, length)
      elsif @afternoon_sessions.has_space?(length)
        @afternoon_sessions.add(title, length)
      end
    end
  end
end

class Talk
  attr_reader :title
  attr_reader :length

  LIGHTNING_TALK_LENGTH = 5

  def initialize(talk)
    @title, @length = title_and_length(talk)
  end

  def self.quantity_of_tracks(talk_lists)
    total_length_of_talks = talk_lists.values.reduce(:+)
    total_length_of_sessions = Session::MORNING_LENGTH + Session::AFTERNOON_LENGTH
    (total_length_of_talks / total_length_of_sessions.to_f).ceil
  end

  def self.update_talk_lists(talk_lists, track)
    track.morning_sessions.talks.each do |talk|
      talk = talk[/(?=\s).*(?=\s)/].strip
      talk_lists.delete_if {|key, value| key == talk }
    end
    
    track.afternoon_sessions.talks.each do |talk|
      talk = talk[/(?=\s).*(?=\s)/].strip
      talk_lists.delete_if {|key, value| key == talk }
    end
    talk_lists
  end

  private

    def title_and_length(talk)
      title = talk[/.*(?=\s)/]
      str_length = talk.split
      if str_length.last.downcase == "talk"
        length = LIGHTNING_TALK_LENGTH
      elsif str_length.last == "minutes"
        length = str_length[-2..-1].join.gsub!("minutes", ' ').to_i
      else
        fail ArgumentError, "invalid talk length"
      end
      [title, length]
    end
end

class ConferenceManager
  file = "#{Dir.pwd}/talks.txt"
  talk_lists = {}
  File.readlines(file).each do |line|
    talk = Talk.new(line.strip)
    talk_lists[talk.title] = talk.length
  end
  
  number_of_tracks = Talk.quantity_of_tracks(talk_lists)
  number_of_tracks.times do |n|
    puts "TRACK #{n + 1}"
    track = Track.new
  
    track.insert_talks_on_track(talk_lists)
    talk_lists = Talk.update_talk_lists(talk_lists, track)
  
    puts "- MORNING SESSION"
    puts track.morning_sessions.talks
    puts "12:00 PM Lunch"
    puts "- AFTERNOON SESSION"
    puts track.afternoon_sessions.talks
    puts "17:00 PM Networking Session"
    puts "==============================="
  end
end
