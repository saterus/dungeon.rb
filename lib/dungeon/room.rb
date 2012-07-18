require_relative 'player'

class Room

  attr_accessor :player, :gold, :x, :y
  attr_reader :doors, :description

  def initialize(x,y, dungeon)
    @x = x
    @y = y
    @description = "You enter a dark and scary room. The walls seem to be getting closer. Did I mention it was scary?"
    @doors = []
    @gold = 10 + rand(11)
    @items = []
    @monster = nil
    @player = nil
    @dungeon = dungeon
  end

  def inspect
    output = ["Room (#{@x}, #{@y}): Gold: #{@gold}"]
    output << "Doors: #{@doors}" unless @doors.empty?
    output << "Player: #{@player}" unless @player.nil?
    output.join(' ')
  end

  def to_s
    "Room (#{@x}, #{@y})"
  end

  def doors_prompt
    if @doors.empty?
      'There are no doors. Oh dear.'
    else
      "There are doors to the #{@doors.to_sentence}."
    end
  end

  def adjacent(direction)
    if direction == :north
      @dungeon.rooms[@x][@y-1]

    elsif direction == :south
      @dungeon.rooms[@x][@y+1]

    elsif direction == :east
      @dungeon.rooms[@x+1][@y]

    elsif direction == :west
      @dungeon.rooms[@x-1][@y]

    end
  end

end
