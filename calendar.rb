#!/usr/bin/env ruby
require "date"
require "optparse"
day = Date.today
params = ARGV.getopts("m:", "y:") 
#getoptsでオプションと引数を指定することができ、受け取ったものをHashとして受け取ることができる
# :を付けると引数を取る

if params["m"]
  mon = params["m"].to_i   
else
  mon = day.mon             
end


if params["y"]
  year = params["y"].to_i
else
  year = day.year
end



top = Date.new(year,mon, 1).strftime("%-m月 %Y")    #Date.new(year,mon, 1)でその月の初日を指定
                                                    #strftime("%B, %Y")で月と西暦を表示
puts top.center(20)

weeks = %w(日 月 火 水 木 金 土 )  # %Wで文字列の配列を作る(チェリー本入門p138)
puts weeks.join(" ")

first_wday = Date.new(year,mon, 1).wday #wdayは曜日を0(日曜日)から6(土曜日)の整数で取得することができるメソッド 
                                        # 2022年3月の場合初日のwdayは2(火曜日)
last_day = Date.new(year,mon, -1).day

print "   " * first_wday  # *演算子をつかって文字列を繰り返す(チェリー本入門p55)
                          # 1日目の日付を記載するための空白を設ける
wday = first_wday


(1..last_day).each do |date|
  print date.to_s.rjust(2) + " "    #rjust 指定した長さの文字列にselfを右詰めした文字列を返す
  wday += 1
  if wday % 7==0                      # 土曜日まで表示したら改行
    print "\n"
  end
end 
if wday % 7 !=0
  print "\n"
end
