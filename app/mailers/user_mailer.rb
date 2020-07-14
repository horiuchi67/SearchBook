class UserMailer < ApplicationMailer
	default from: "from@example.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation(resource)
    @greeting = "ご登録ありがとうございます。"

    mail(to: resource.email, subject: '『SearchBook』へようこそ')
  end
end