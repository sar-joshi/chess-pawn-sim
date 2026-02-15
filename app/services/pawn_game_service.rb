class PawnGameService
  def initialize(pawn_game)
    @game = pawn_game
    @board = Board.new
    @pawn = current_pawn
  end

  def run(input)
    # Handle multilines command
    commands = input.to_s.split("\n").map(&:strip).reject(&:empty?)

    commands.each do |command|
      run_command(command)
    end

    save_game
  end

  private

  def current_pawn
    return unless @game.placed?

    Pawn.new(@game.xpos, @game.ypos, @game.facing, @game.colour)
  end

  def run_command(str)
    input = str.strip.upcase
    cmd = input[/^\s*([A-Za-z]+)/, 1].to_sym # Extract chars until the first digit or whitespace, e.g. "PLACE 1..." -> "PLACE".
    rest = input.sub(/\A[A-Za-z]+\s*/i, "") # Rest of the arguments, e.g, "1, 2, NORTH, WHITE".
    args = rest.split(",").map(&:strip) # Split on commas and strip extra whitespaces if any.

    # Ignore all commands until a valid intital command
    return unless cmd == :PLACE || @pawn

    case cmd
    when :PLACE then place(args)
    when :MOVE then move(args[0])
    when :LEFT then @pawn.rotate(:LEFT)
    when :RIGHT then @pawn.rotate(:RIGHT)
    when :REPORT then log("REPORT: #{@pawn.report}")
    end
  end

  def place(args)
    # args: [x,y,facing,colour]
    x, y = args[0].to_i, args[1].to_i
    facing, colour = args[2], args[3]

    if @board.position_in_bound?(x, y)
      @pawn = Pawn.new(x, y, facing, colour)
      log("Placed at #{x},#{y},#{facing},#{colour}")
    end
  end

  def move(steps)
    max_steps = @pawn.has_moved ? 1 : 2
    pawn_steps = [ steps.to_i, max_steps ].min # Ignore invalid steps

    dx, dy = @pawn.soft_move(pawn_steps)

    # prevet pawn to fall off the board
    if @board.position_in_bound?(dx, dy)
      @pawn.update_position(dx, dy)
      log("Moved to #{dx},#{dy} from #{pawn.x},#{pawn.y}")
    else
      log("Invalid Moved: Out of boundry")
    end
  end

  def log(message)
    @game.add_log(message)
  end

  def save_game
    return unless @pawn

    @game.assign_attributes(
      xpos: @pawn.x,
      ypos: @pawn.y,
      facing: @pawn.facing,
      colour: @pawn.colour
    )
    @game.save!
  end
end
