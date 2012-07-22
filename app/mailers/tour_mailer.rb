# coding: utf-8
class TourMailer < ActionMailer::Base
  default :content_type => 'text/html',
          :from => Settings.mailer.from

  def reserve info
  	@info = info
  	mail(:to => Settings.mailer.to, :subject => Settings.mailer.subject)
  end
end
