# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(argument)
    scores = argument.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << 10
        shots << 0 if shots.size <= 17
      else
        shots << s
      end
    end

    @frames = create_frames(shots)
  end

  def create_frames(shots)
    frames = []
    shots.each_slice(2) do |s|
      if frames.size == 10
        frames[9] << s
      else
        frames << s
      end
    end
    frames[9].flatten!

    frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
  end

  def calculate_score
    point = 0
    @frames.each_with_index do |frame, i|
      if i == 9
        point += frame.frame_score
      elsif frame.first_score == 10
        point += strike_score(i)
      elsif frame.frame_score == 10
        point += spare_score(i)
      else
        point += frame.frame_score
      end
    end
    point
  end

  def strike_score(current_frame)
    if @frames[current_frame + 1].first_score == 10 && current_frame == 8
      @frames[current_frame + 1].first_score + @frames[current_frame + 1].second_score + 10
    elsif @frames[current_frame + 1].first_score == 10
      10 + @frames[current_frame + 2].first_score + 10
    else
      @frames[current_frame + 1].first_score + @frames[current_frame + 1].second_score + 10
    end
  end

  def spare_score(current_frame)
    @frames[current_frame + 1].first_score + 10
  end
end
