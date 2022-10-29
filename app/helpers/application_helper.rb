module ApplicationHelper
  require 'date'

  def countdown_to_friday
    if Date.today.wday == 5
      "本日は金曜日です"
    elsif Date.today.wday == 4
      "金曜日まであと1日"
    elsif Date.today.wday == 3
        "金曜日まであと2日"
    elsif Date.today.wday == 2
        "金曜日まであと3日"
    elsif Date.today.wday == 1
        "金曜日まであと4日"
    elsif Date.today.wday == 0
        "金曜日まであと5日"
    else Date.today.wday == 6
        "金曜日まであと6日"
    end
  end
end
