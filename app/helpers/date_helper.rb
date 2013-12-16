module DateHelper
  def event_time(begins_at, ends_at=nil)
    if ends_at
      total_seconds = ends_at - begins_at
      seconds = total_seconds % 60
      minutes = (total_seconds / 60) % 60
      hours = total_seconds / (60 * 60)
    end
    if begins_at && !ends_at
      simple_format( "<span class='label success'><i class='fi-clock'></i> #{begins_at.strftime("%a %b %d, %y : %l:%M:%S %p") } </span>")        
    elsif begins_at.to_date == ends_at.to_date
      simple_format( "<span class='label success'><i class='fi-clock'></i> #{begins_at.strftime("%a %b %d, %y : %l:%M:%S %p") } </span><span class='label secondary'> #{format("%01d:%02d hrs", hours, minutes, seconds)} </span>")
    else
      simple_format( "<span class='label success'><i class='fi-clock'></i> #{begins_at.strftime("%a %b %d, %y : %l:%M:%S %p") } </span><span class='label secondary'> #{format("%01d:%02d hrs", hours, minutes, seconds)} </span>")
    end
  end

end
