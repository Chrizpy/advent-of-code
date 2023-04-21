# frozen_string_literal: true

require_relative "../lib/santa"

describe Santa do
  before do
    subject { described_class.new }
  end

  it "responds to a 'position' attribute" do
    expect(subject.respond_to?(:position)).to be(true)
  end

  it "responds to a 'houses_visited' attribute" do
    expect(subject.respond_to?(:houses_visited)).to be(true)
  end

  it "starts with position X set to zero" do
    expect(subject.position.x).to eq(0)
  end

  it "starts with position Y set to zero" do
    expect(subject.position.x).to eq(0)
  end

  describe "#move" do
    let(:instructions_data)   { "^vv<>>" }
    let(:parsed_instructions) { described_class.parse_instructions(instructions_data) }

    before do
      parsed_instructions.each do |instruction|
        subject.move(instruction)
      end
    end

    it "has the correct position X after move" do
      expect(subject.position.x).to eq(1)
    end

    it "has the correct position Y after move" do
      expect(subject.position.y).to eq(-1)
    end
  end

  describe "#houses_visited_at_least_once" do
    let(:parsed_instructions) { described_class.parse_instructions(instructions_data) }

    before do
      parsed_instructions.each do |instruction|
        subject.move(instruction)
      end
    end

    context "when '>'" do
      let(:instructions_data) { ">" }

      it "has visited 2 houses at least once" do
        expect(subject.houses_visited_at_least_once).to eq(2)
      end
    end

    context "when '^>v<'" do
      let(:instructions_data) { "^>v<" }

      it "has visited 4 houses at least once" do
        expect(subject.houses_visited_at_least_once).to eq(4)
      end
    end
  end

  describe ".parse_instructions" do
    let(:instructions_data) { "^v<>" }

    let(:parsed_instructions) { described_class.parse_instructions(instructions_data) }

    it "parses the instructions to 'Step' objects" do
      expect(parsed_instructions).to eq([Step.new(:y, 1), Step.new(:y, -1), Step.new(:x, -1), Step.new(:x, 1)])
    end

    context "when a text file is provided instead" do
      before do
        ENV["INSTRUCTIONS"] = "fixture/example_data.txt"
      end

      let(:parsed_instructions) { described_class.parse_instructions }

      it "parses the instructions to 'Step' objects" do
        expect(parsed_instructions).to all(be_a(Step))
      end
    end
  end
end
