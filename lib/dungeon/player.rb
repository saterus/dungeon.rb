class Player

  attr_accessor :room

  ACTIONS = [:move, :look, :quit]

  def initialize(name)
    @name = name
    @room = nil
  end

  def to_s
    "#{@name} (Hero)"
  end

  def take_action(command, args)
    command = command.to_sym
    # check for command availability?
    if ACTIONS.include?(command)
      if command == :look
        # do nothing, we'll print again
      elsif command == :quit
        # do nothing, we'll exit from dungeon.rb
      elsif command == :move
        direction = args.first.to_sym
        move(direction)
      end
    else
      raise "Cannot take that action! #{command} with args #{args}"
    end

  end

  def move(direction)
    if room.doors.include? direction
      next_room = @room.adjacent(direction)
      @room.player = nil
      next_room.player = self
      @room = next_room
    else
      puts "You cannot move that direction!"
    end

  end

end
