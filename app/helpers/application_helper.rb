module ApplicationHelper
  def adoption_status_badge(status)
    case status.to_s
    when 'approved' then 'success'
    when 'pending' then 'warning'
    when 'rejected' then 'danger'
    else 'info'
    end
  end
end
