class Card
  def initialize(value, type)
    @value = value
    @type = type
  end

  def to_s
    "|#{@value} #{@type}|"
  end
end
