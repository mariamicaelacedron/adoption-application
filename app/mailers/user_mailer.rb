# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def adoption_approved(adoption)
    @adoption = adoption
    @user = adoption.user
    mail(
      to: @user.email,
      subject: "¡Tu solicitud de adopción ha sido aprobada!"
    )
  end

  def adoption_rejected(adoption)
    @adoption = adoption
    @user = adoption.user
    mail(
      to: @user.email,
      subject: "Actualización sobre tu solicitud de adopción"
    )
  end
end