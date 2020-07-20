require "time"

class Session
  attr_accessor :talks
  attr_accessor :available_time
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

  def can_fit?(talk)
    @available_time >= talk[1]
  end

  def add(talk)
    title = talk[0]
    length = talk[1]
    @available_time -= length
    @talks << "#{scheduled_time(length)} #{title} #{length_format(length)}"
  end

  private
  
    def scheduled_time(length)
      time_format = format('%02d:%02d', @time.hour, @time.min)
      @time += (60 * length)
      time_format
    end

    def length_format(length)
      length == 5 ? "talk" : "minutes"
    end
end

class Track
  attr_reader :morning_session
  attr_reader :afternoon_session

  def initialize
    @morning_session   = Session.new("morning")
    @afternoon_session = Session.new("afternoon")
  end

  def insert_talks(talk_lists)
    talk_lists.each do |talk|
      if @morning_session.can_fit?(talk)
        @morning_session.add(talk)
      elsif @afternoon_session.can_fit?(talk)
        @afternoon_session.add(talk)
      end
    end
  end

  def self.quantity_of_tracks(talk_lists)
    total_length_of_talks = talk_lists.values.reduce(:+)
    total_length_of_session = Session::MORNING_LENGTH + Session::AFTERNOON_LENGTH
    (total_length_of_talks / total_length_of_session.to_f).ceil
  end

  def self.update_talk_lists(talk_lists, track)
    track.morning_session.talks.each do |talk|
      talk = talk[/(?=\s).*(?=\s)/].strip
      talk_lists.delete_if {|key, value| key == talk }
    end
    
    track.afternoon_session.talks.each do |talk|
      talk = talk[/(?=\s).*(?=\s)/].strip
      talk_lists.delete_if {|key, value| key == talk }
    end
    talk_lists
  end
end

class Talk
  attr_reader :title
  attr_reader :length

  LIGHTNING_TALK_LENGTH = 5

  def initialize(talk)
    @title, @length = title_and_length(talk)
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
  def initialize
    @talk_lists = {}
    read_file
  end

  private

    def read_file
      file = "#{Dir.pwd}/talks.txt"
      File.readlines(file).each do |line|
        talk = Talk.new(line.strip)
        @talk_lists[talk.title] = talk.length
      end
      generate_schedule
    end

    def generate_schedule
      number_of_tracks = Track.quantity_of_tracks(@talk_lists)
      number_of_tracks.times do |n|
        puts "TRACK #{n + 1}"
        track = Track.new
      
        track.insert_talks(@talk_lists)
        talk_lists = Track.update_talk_lists(@talk_lists, track)

        puts "- MORNING SESSION"
        puts track.morning_session.talks
        puts "12:00 PM Lunch"
        puts "- AFTERNOON SESSION"
        puts track.afternoon_session.talks
        puts "17:00 PM Networking Session"
        puts "==============================="
      end
    end
end

ConferenceManager.new
