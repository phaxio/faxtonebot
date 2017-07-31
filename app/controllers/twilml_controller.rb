class TwilmlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def pause
    response = Twilio::TwiML::Response.new do |r|
      r.Record(
        transcribe: true,
        transcribeCallback: ENV['PUBLIC_HOST'] + Rails.application.routes.url_helpers.transcriptions_path
      )
      r.Pause '', length: 30
    end

    render text: response.text
  end
end
