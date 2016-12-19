require 'time'
require 'date'

module TimeService
  # A mixin takes care of time ouput and offset service.

  def year_month(time)
    time.strftime("%Y-%m")
  end

  def date(time)
    time.strftime("%d")
  end

  def hour(time)
    time.strftime("%k").strip
  end

  def same_month?(time1s, time2)
    year_month(time1) == year_month(time2)
  end

  def within_time_range?(event_time, after_time, before_time)
    after_time <= event_time && event_time <= before_time
  end

  def offset_date_time(date_time, offset)
    utc_time = date_time.to_time.utc
    offset_time = utc_time.to_datetime.new_offset(offset)
  end

  def datetime_to_utc(date_time)
    offset_date_time(date_time, 0)
  end
end