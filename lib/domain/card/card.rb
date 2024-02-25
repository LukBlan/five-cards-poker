class Card
  attr_reader :type, :value

  def initialize(value, type)
    @value = value
    @type = type
  end

  def to_s
    "|#{@value} #{@type}|"
  end
end
