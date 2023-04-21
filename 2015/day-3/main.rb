# frozen_string_literal: true

require_relative "lib/santa"

def part_one
  santa = Santa.new

  instructions = Santa.parse_instructions

  instructions.each do |instruction|
    santa.move(instruction)
  end

  santa.houses_visited_at_least_once
end

def part_two # rubocop:disable Metrics/MethodLength
  santa      = Santa.new
  robo_santa = Santa.new

  santas_turn  = true
  instructions = Santa.parse_instructions

  instructions.each do |instruction|
    if santas_turn
      santa.move(instruction)

      santas_turn = false
    else
      robo_santa.move(instruction)

      santas_turn = true
    end
  end

  santa.houses_visited.merge(robo_santa.houses_visited).uniq.count
end

puts "--- Part One ---"
puts "#{part_one}\n"

puts "--- Part Two ---"
puts "#{part_two}\n"
