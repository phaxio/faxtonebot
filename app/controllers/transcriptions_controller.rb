class TranscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    tone_check = ToneCheck.find params[:id]

    text = params['TranscriptionText']
    if text.strip.present?
      tone_check.update! result: 'Voice Detected', note: "Transcript: \"#{text}\""
    end

    head :ok
  end
end
