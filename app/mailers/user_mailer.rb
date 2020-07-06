class UserMailer < ApplicationMailer

	default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_welcome_mail.subject
  #
  def user_welcome_mail
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
