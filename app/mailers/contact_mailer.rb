class ContanctMailer < ActionMailer::Base

	def send_contact_info(contact)
		to = [{ email: contact[:email], name: contact[:name] }]
	    template_name = "contact-thank-you"
	    message = {
	      to: to,
	      subject: "Thank you for Contacting SGPFH",
	      global_merge_vars: [
	        { name: 'NAME', content: contact[:name] },
	        { name: 'PROGRAM', content: contact[:program] },
	        { name: 'LINK', content: 'http://sgpfh.org' }
	      ]
	    }
	    MANDRILL.messages.send_template template_name, [], message
	end

	def get_contact_info(contact)
		to = get_admin_emails
	    template_name = "contact-info"
	    message = {
	      to: to,
	      subject: "#{contact[:name]} Reached Out to the SGPFH",
	      global_merge_vars: [
	        { name: 'NAME', content: contact[:name] },
	        { name: 'PROGRAM', content: contact[:program] },
	        { name: 'EMAIL', content: contact[:email] },
	        { name: 'PHONE', content: contact[:phone] },
	        { name: 'COMMENT', content: contact[:comment] }
	      ]
	    }
	    MANDRILL.messages.send_template template_name, [], message
	end

	private

	def get_admin_emails
		Users.all.admins.map { |a| { email: a.email, name: a.name } }
	end

end
