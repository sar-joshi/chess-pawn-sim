class Pawn
  attr_reader :x, :y, :facing, :colour, :has_moved

  # Constants
  FACINGS = %w[NORTH EAST SOUTH WEST].freeze
  ROTATIONS = {
    LEFT:  { NORTH: :WEST, WEST: :SOUTH, SOUTH: :EAST, EAST: :NORTH },
    RIGHT: { NORTH: :EAST, EAST: :SOUTH, SOUTH: :WEST, WEST: :NORTH }
  }.freeze

  def initialize(x, y, facing, colour, has_moved = false)
    @x = x.to_i
    @y = y.to_i
    @facing = facing.to_sym
    @colour = colour.to_sym
    @has_moved = has_moved
  end

  def soft_move(steps)
    # calculate new position
    dx, dy = case facing
    when :NORTH then [ 0, 1 ]
    when :SOUTH then [ 0, -1 ]
    when :EAST then [ 1, 1 ]
    when :WEST then [ -1, 0 ]
    end

    { x: x + (dx * steps), y: y + (dy * steps) }
  end

  def rotate(side)
    # sides: :LEFT or :RIGHT
    @facing = ROTATIONS[side][facing]
  end

  def update_position(x, y)
    @has_moved = true
    @x, @y = x, y
  end

  def report
    "#{x},#{y},#{facing},#{colour}"
  end
end
