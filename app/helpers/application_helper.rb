module ApplicationHelper

  def standard_date(date)
    date.in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y at %l:%M %p") if date
  end

  def excel_date(date)
    date.in_time_zone('Pacific Time (US & Canada)').strftime("%Y-%m-%d") if date
  end

end
