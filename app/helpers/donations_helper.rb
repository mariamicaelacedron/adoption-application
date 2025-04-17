module DonationsHelper
  def adoption_status_badge(status)
    case status.to_s
    when 'pending' then 'warning'
    when 'approved' then 'success'
    when 'rejected' then 'danger'
    else 'secondary'
    end
  end
end