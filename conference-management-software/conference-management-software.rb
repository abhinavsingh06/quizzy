class Talk
  attr_reader :description
  attr_reader :length

  LIGHTNING_LENGTH = 5

  def initialize(talk)
    words = talk.split
    if words.last == 'talk'
      @length = LIGHTNING_LENGTH
    elsif words[-2..-1].join.match(words.last)
      @length = words[-2..-1].join.gsub('minutes', ' ').to_i
    else
      puts 'incorrect format'
    end
    @description = talk
  end
end

class ConferenceManager
  list = []

  File = File.readlines("#{Dir.pwd}/talks.txt")
  File.each{|line| list << Talk.new(line.gsub(/\n/, ''))}
end
