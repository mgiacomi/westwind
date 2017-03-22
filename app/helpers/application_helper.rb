module ApplicationHelper

  def mins_to_words mins
    hh, mm = mins.divmod(60)
    if hh > 0
      if hh > 1
        "%d hours %d minutes" % [hh, mm]
      else
        "%d hour %d minutes" % [hh, mm]
      end
    else
      "%d minutes" % [mm]
    end
  end

  def days_to_end
    days_to_end = (Rails.configuration.end_date - Time.zone.today).to_i
    days_to_end < 0 ? 0 : days_to_end
  end
end
