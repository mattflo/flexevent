class Votingtime < ActionMailer::Base
  default from: "grnfvr@gmail.com"
  def voting_open_notification voter
  	@voter = voter
    mail(:to => voter.email, :subject => "FlexEvent Voting Time")
  end
end
