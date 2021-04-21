class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.gmail[:user_name] #差出人のメールアドレス
  layout 'mailer'
end