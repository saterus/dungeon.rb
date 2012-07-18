require_relative 'dungeon/array_extensions'
require_relative 'dungeon/room'
require_relative 'dungeon/player'

class Dungeon

  attr_reader :rooms

  # init
  def initialize
    # - make rooms
    @rooms = Array.new(5) do |x|
      Array.new(5) do |y|
        Room.new(x,y, self)
      end
    end

    # - connect rooms
    make_passage(0, 3, :south)
    make_passage(0, 4, :east)
    make_passage(1, 4, :east)
    make_passage(2, 4, :east)
    make_passage(3, 4, :east)
    make_passage(2, 3, :south)

    # - make player
    print "What is the name of your hero? "
    name = gets.chomp
    @player = Player.new(name)

    start_room = @rooms[0][4]
    start_room.player = @player
    @player.room = start_room
    start_room.gold = 0


    # game loop
    puts "Type h for Help."
    # @player.print_help

    input = nil
    while input != 'quit'

      puts "At (#{@player.room.x},#{@player.room.y})"
      puts @player.room.description
      puts @player.room.doors_prompt
      puts "What would you like to do? "

      input = gets.chomp
      command, *args = input.split(' ')
      puts "\n"

      @player.take_action(command, args)
      puts "\n"
    end
  end

  def make_passage(x,y, direction = :east)
    if direction == :east
      if x > 3
        raise "Cannot make passages to the outside world! (#{x}, #{y})"
      end

      origin = @rooms[x][y]
      destination = @rooms[x+1][y]

      origin.doors << :east
      destination.doors << :west

    elsif direction == :south
      if y > 3
        raise "Cannot make passages to the outside world! (#{x}, #{y})"
      end

      origin = @rooms[x][y]
      destination = @rooms[x][y+1]

      origin.doors << :south
      destination.doors << :north

    else
      raise "Can only make doors going East or South! You tried to go #{direction}!"
    end
  end


  # run loop
  # - print description, doors, gold, monsters
  # - ask for action
  # - execute action

  def print_rooms
    puts "\n\n"
    puts "Rooms: "
    5.times { |y|
      5.times { |x|
        print "#{@rooms[x][y].inspect} "
      }
      puts ''
    }
    puts "\n\n"
  end
end

# if we are running this file, execute this bit of code
# otherwise ignore it
if __FILE__ == $0
  puts "Running Dungeon.rb"

  dungeon = Dungeon.new

  puts "Ending Dungeon.rb"
end
