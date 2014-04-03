class Notifier < ActionMailer::Base
	default from: 'noreply@ldi.org.pl'

  	def welcome()
    	mail(to: recipient.email_address_with_name)
  	end
end
