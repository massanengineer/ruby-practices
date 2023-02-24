#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if shots.size > 17 && s == 'X' # 10フレーム目
    shots << 10
  elsif s == 'X'
    shots << 10
    shots << 0
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
frames[9].flatten! # frame[9]の3次元配列の修正

point = 0
frames.each_with_index do |frame, i| # 例」frame[6,3] frames[[6,3][9,0]...]
  if i == 9 # 10フレーム目
    point += frame.sum
  elsif frame[0] == 10 # 1回目ストライク　
    if frames[i + 1][0] == 10 && i == 8 # 次の1投目がストライクかつ9フレーム
      point += frames[i + 1][0] + frames[i + 1][1] + 10
    elsif frames[i + 1][0] == 10 # 次の1投目がストライク
      point += 10 + frames[i + 2][0] + 10
    elsif frames[i + 1][0] != 10 # 次の1投目がストライク以外
      point += frames[i + 1][0] + frames[i + 1][1] + 10
    end
  elsif frame.sum == 10 # スペア
    point += frames[i + 1][0] + 10
  else
    point += frame.sum
  end
end
puts point
