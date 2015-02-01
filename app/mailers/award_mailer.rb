class AwardMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_award_email(award)
  	@award = award
  	get_approval_emails.each do |r|
  		@hash = r.slug
  		mail(to: r.email, subject: "New Award Created")	
  	end
  end

  private

  def get_approval_emails
  	affiliates = Affiliate.where(:get_email => true)
  	affiliates
  end

end
