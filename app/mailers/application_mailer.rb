class ApplicationMailer < ActionMailer::Base
  default from: ENV["GMAIL_DEV"]
  layout "mailer"
end
