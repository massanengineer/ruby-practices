# frozen_string_literal: true

class Shot
  def initialize(mark)
    @mark = mark
  end

  def shot
    @mark == 'X' ? Strike_point : @mark.to_i
  end
end
