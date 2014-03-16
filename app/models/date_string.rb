class DateString
  def self.new date, end_date
    if date == end_date
      date.strftime("#{date.day.ordinalize} %B %Y")
    else
      if last_day_of_month date
        date.strftime("#{date.day.ordinalize} %B, ")
      else
        date.strftime("#{date.day.ordinalize}, ")
      end
    end
  end

  def self.last_day_of_month date
    date.month != (date + 1.day).month
  end
end
