class AwardMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_award_email(award)
  	@award = award
  	award.affiliates.each do |r|
  		@hash = r.slug
  		mail(to: r.email, subject: "New Award Created")	
  	end
  end

  def approval_request(award)
    to = award.affiliates.map { |a| { email: a.email, name: a.name } }
    template_name = "approval-request"
    message = {
      to: to,
      subject: "Award for #{award.patient.name}",
      global_merge_vars: [
        { name: 'NAME', content: award.patient.name },
        { name: 'LINK', content: 'http://sgpfh.org/users/sign_in' }
      ]
    }
    MANDRILL.messages.send_template template_name, [], message
  end

end
