
require_relative 'frame.rb'

class Game
  def initialize(argument)
    
    scores = argument.split(',')
    shots = []
    scores.each do |s|
      if s == 'X'
        shots << 10
        shots << 0 if shots.size <= 17
      else
        shots << s.to_i
      end
    end

    frames = []
    shots.each_slice(2) do |s|
      if frames.size == 10
        frames[9] << s
      else
        frames << s
      end
    end
    frames[9].flatten!

    @frames = frames.map { |frame| Frame.new(frame[0], frame[1], frame[2]) }

  end

  def calculate_score
 
    point = 0

    @frames.each_with_index do |frame, i|
      if i == 9
        
        point += frame.frame_score
        
      elsif frame.first_score == 10 # 1回目ストライク
        
        if @frames[i + 1].first_score == 10 && i == 8 # 次の1投目がストライクかつ9フレーム
          point += @frames[i + 1].first_score + @frames[i + 1].second_score + 10
        elsif @frames[i + 1].first_score == 10 # 次の1投目がストライク

          point += 10 + @frames[i + 2].first_score + 10
        elsif @frames[i + 1].first_score != 10 # 次の1投目がストライク以外
          point += @frames[i + 1].first_score + @frames[i + 1].second_score + 10
        end
      elsif frame.frame_score == 10 # スペア
        point += @frames[i + 1].first_score + 10
      else
        point += frame.frame_score
      end
    end
    point
  end
end