class Ship
  attr_reader :length, :damage
  def initialize(length)
    fail "Length must be a positive integer." unless valid_length?(length)

    @length = length
    @damage = 0
  end

  def hit
    @damage += 1
  end

  def sunk?
    @damage >= @length
  end

  private

  def valid_length?(length)
    length.is_a?(Integer) && length.positive?
  end
end