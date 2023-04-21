# frozen_string_literal: true

Step     = Struct.new(:direction, :steps)
Position = Struct.new(:x, :y)

INSTRUCTIONS = ENV.fetch("INSTRUCTIONS_DATA", "instructions.txt")

class Santa
  attr_accessor :position, :houses_visited

  def initialize
    @position       = Position.new(0, 0)
    @houses_visited = {}

    add_house_to_visit_map
  end

  def move(step)
    direction = step.direction
    steps     = step.steps

    if direction == :y
      position.y += steps
    else
      position.x += steps
    end

    add_house_to_visit_map
  end

  def houses_visited_at_least_once
    houses_visited.keys.uniq.count
  end

  def self.parse_instructions(instructions_data = nil)
    instructions = []

    instructions_data = if instructions_data.nil?
                          File.read(INSTRUCTIONS).chars
                        else
                          instructions_data.chars
                        end

    instructions_data.each do |instruction|
      instructions.append(translate_instruction_into_step(instruction))
    end

    instructions
  end

  private_class_method def self.translate_instruction_into_step(instruction)
    case instruction
    when "^"
      Step.new(:y, 1)
    when "v"
      Step.new(:y, -1)
    when "<"
      Step.new(:x, -1)
    when ">"
      Step.new(:x, 1)
    end
  end

  private

  def add_house_to_visit_map
    house_position = Position.new(position.x, position.y)

    houses_visited[house_position] ? houses_visited[house_position] += 1 : houses_visited[house_position] = 1
  end
end
