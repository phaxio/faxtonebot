class TwilmlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def record
    tone_check_id = params[:id]

    response = Twilio::TwiML::Response.new do |r|
      r.Record(
        transcribe: true,
        transcribeCallback: ENV['PUBLIC_HOST'] + Rails.application.routes.url_helpers.create_transcription_path(tone_check_id)
      )
      r.Pause '', length: 30
    end

    render text: response.text
  end
end
