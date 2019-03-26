class TwilmlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pause
    response = Twilio::TwiML::VoiceResponse.new
    response.pause(length: 30)

    render text: response.to_s
  end
end
