# frozen_string_literal: true

require_relative 'frame'

STRIKE_POINT = 10
SPARE_POINT = 10

class Game
  def initialize(argument)
    scores = argument.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << STRIKE_POINT
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
      point += if i == 9
                 frame.basis_point
               elsif frame.strike?
                 frame.strike_score(@frames[i + 1], @frames[i + 2], i)
               elsif frame.spare?
                 frame.spare_score(@frames[i + 1])
               else
                 frame.basis_point
               end
    end
    point
  end

  private

  def create_frames(shots)
    frames = []
    shots.each_slice(2) do |s|
      if frames.size == STRIKE_POINT
        frames[9] << s
      else
        frames << s
      end
    end
    frames[9].flatten!

    frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
  end
end
