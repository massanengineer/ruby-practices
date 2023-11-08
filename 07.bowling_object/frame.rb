# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score, :second_score

  def initialize(index, first_mark, second_mark, third_mark)
    @index = index
    @first_score = Shot.new(first_mark).shot
    @second_score = Shot.new(second_mark).shot
    @third_score = Shot.new(third_mark).shot
  end

  def basis_score
    if @index == 9 && strike?
      STRIKE_SCORE
    else
      @first_score + @second_score
    end
  end

  def bonus_score(next_frame, after_next_frame)
    if @index == 9
      if strike?
        @second_score + @third_score
      elsif spare?
        @third_score
      else
        0
      end
    elsif strike?
      not_final_frame_strike_bonus(next_frame, after_next_frame)
    elsif spare?
      not_final_frame_spare_score(next_frame)
    else
      0
    end
  end

  def strike?
    @first_score == STRIKE_SCORE
  end

  def spare?
    return false if strike?

    @first_score + @second_score == SPARE_SCORE
  end

  private

  def not_final_frame_strike_bonus(next_frame, after_next_frame)
    if next_frame.strike? && @index == 8
      next_frame.first_score + next_frame.second_score
    elsif next_frame.strike?
      STRIKE_SCORE + after_next_frame.first_score
    else
      next_frame.first_score + next_frame.second_score
    end
  end

  def not_final_frame_spare_score(next_frame)
    next_frame.first_score
  end
end
