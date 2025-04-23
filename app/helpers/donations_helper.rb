module DonationsHelper
  def donation_status_badge(status)
    case status.to_s
    when 'completed' then 'success'
    when 'pending' then 'warning'
    when 'canceled' then 'secondary'
    else 'info'
    end
  end
  
  def donation_status_full_badge(donation)
    content_tag(:span, donation.status.humanize, 
                class: "badge bg-#{donation_status_badge(donation.status)}")
  end
end