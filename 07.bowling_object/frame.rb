# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score, :second_score

  def initialize(first_mark, second_mark, third_mark)
    @first_score = Shot.new(first_mark).shot
    @second_score = Shot.new(second_mark).shot
    @third_score = Shot.new(third_mark).shot
  end

  def basis_score
    @first_score + @second_score
  end

  def bonus_score(next_frame, after_next_frame, index)
    if index == 9
      if strike? || spare?
        @third_score
      else
        0
      end
    elsif strike?
      strike_score(next_frame, after_next_frame, index)
    elsif spare?
      spare_score(next_frame)
    else
      0
    end
  end

  def strike?
    @first_score == STRIKE_SCORE
  end

  def spare?
    @first_score + @second_score == SPARE_SCORE && !strike?
  end

  def strike_score(next_frame, after_next_frame, index)
    if next_frame.strike? && index == 8
      next_frame.first_score + next_frame.second_score
    elsif next_frame.strike?
      STRIKE_SCORE + after_next_frame.first_score
    else
      next_frame.first_score + next_frame.second_score
    end
  end

  def spare_score(next_frame)
    next_frame.first_score
  end
end
