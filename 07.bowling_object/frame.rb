# frozen_string_literal: true

require_relative 'shot'
require 'debug'
class Frame
  attr_reader :first_score, :second_score

  def initialize(first_mark, second_mark, third_mark)
    @first_score = Shot.new(first_mark).shot
    @second_score = Shot.new(second_mark).shot
    @third_score = Shot.new(third_mark).shot
  end

  def basis_point
    @first_score + @second_score + @third_score
  end

  def strike?
    @first_score == STRIKE_POINT
  end

  def spare?
    @first_score + @second_score == SPARE_POINT
  end

  def strike_score(next_frame, after_next_frame, index)
    if next_frame.strike? && index == 8
      next_frame.first_score + next_frame.second_score + STRIKE_POINT
    elsif next_frame.strike?
      STRIKE_POINT + after_next_frame.first_score + STRIKE_POINT
    else
      next_frame.first_score + next_frame.second_score + STRIKE_POINT
    end
  end

  def spare_score(next_frame)
    next_frame.first_score + SPARE_POINT
  end
end
