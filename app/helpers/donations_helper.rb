module DonationsHelper
  def status_badge_color(status)
    case status
    when 'completado' then 'success'
    when 'pendiente' then 'warning'
    when 'cancelado' then 'danger'
    else 'secondary'
    end
  end
end