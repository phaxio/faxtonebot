require 'twilio-ruby'

account_sid = 'AC53a1e3242d7fe4e32fbefc73c420b105'
auth_token = 'cd26b57c7beca600bd33f38791e972ef'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@call = @client.account.calls.create(
  :from => '+1 847-701-5474',
  :to => '17633891621',
  :url => 'http://joshnankin.com/pause.xml',
  :StatusCallback => 'http://2e76oayxu2or.runscope.net',
  :Record => true,
  :method => 'get'

)
