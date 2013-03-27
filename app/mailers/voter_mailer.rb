class VoterMailer < ActionMailer::Base
  default from: "grnfvr@gmail.com"
  def invite(voter)
  	@voter = voter
    mail(:to => @voter.email, :subject => "#{@voter.event.name} - flexevent voting is open")
  end
end
