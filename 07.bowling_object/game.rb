# frozen_string_literal: true

require_relative 'frame'

Strike_point = 10
Spare_point = 10

class Game
  def initialize(argument)
    scores = argument.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << Strike_point
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
      if i == 9
        point += frame.basis_point
      elsif frame.strike?
        point += strike_score(i)
      elsif frame.spare?
        point += spare_score(i)
      else
        point += frame.basis_point
      end
    end
    point
  end

  private

  def create_frames(shots)
    frames = []
    shots.each_slice(2) do |s|
      if frames.size == Strike_point
        frames[9] << s
      else
        frames << s
      end
    end
    frames[9].flatten!

    frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }
  end


  def strike_score(current_frame)
    if @frames[current_frame + 1].first_score == Strike_point && current_frame == 8
      @frames[current_frame + 1].first_score + @frames[current_frame + 1].second_score + Strike_point
    elsif @frames[current_frame + 1].first_score == Strike_point
      Strike_point + @frames[current_frame + 2].first_score + Strike_point
    else
      @frames[current_frame + 1].first_score + @frames[current_frame + 1].second_score + Strike_point
    end
  end

  def spare_score(current_frame)
    @frames[current_frame + 1].first_score + Spare_point
  end
end
