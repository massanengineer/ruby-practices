# frozen_string_literal: true

require_relative 'shot'

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
    @first_score == Strike_point
  end

  def spare?
    @first_score + @second_score == Spare_point
  end
end
