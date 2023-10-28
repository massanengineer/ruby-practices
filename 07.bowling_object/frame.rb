# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_score, :second_score, :third_score

  def initialize(first_mark, second_mark, third_mark)
    @first_score = Shot.new(first_mark).shot
    @second_score = Shot.new(second_mark).shot
    @third_score = Shot.new(third_mark).shot
  end

  def frame_score
    (@first_score || 0) + (@second_score || 0) + (@third_score || 0)
  end
end
