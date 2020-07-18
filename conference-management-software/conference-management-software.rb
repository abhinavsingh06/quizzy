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
      length == 5 ? "talk" : "#{length}minutes"
    end
end
