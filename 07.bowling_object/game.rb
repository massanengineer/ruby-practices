# frozen_string_literal: true

require_relative 'frame'
require 'debug'
STRIKE_SCORE = 10
SPARE_SCORE = 10

class Game
  def initialize(argument)
    scores = argument.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << STRIKE_SCORE
        shots << 0 if shots.size <= 17
      else
        shots << s
      end
    end

    @frames = create_frames(shots)
  end

  def calculate_score
    point = 0
    @frames.each_with_index do |frame, i|
      point += frame.basis_score + frame.bonus_score(@frames[i + 1], @frames[i + 2])
    end
    point
  end

  private

  def create_frames(shots)
    frames = []
    shots.each_slice(2) do |s|
      if frames.size == STRIKE_SCORE
        frames[9] << s
      else
        frames << s
      end
    end
    frames[9].flatten!
    frames.map.with_index { |frame, index| Frame.new(index, frame[0], frame[1], frame[2])  }
  end
end
