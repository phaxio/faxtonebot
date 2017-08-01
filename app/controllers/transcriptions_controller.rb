class TranscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    tone_check = ToneCheck.find params[:id]

    text = params['TranscriptionText']
    if text.strip.present?
      tone_check.note = "#{tone_check.note}\n\nTranscript: \"#{text}\"".strip
      tone_check.result = "#{tone_check.result} [Voice Detected]".strip
    else
      tone_check.result = "#{tone_check.result} [Fax Tone Detected]".strip
    end

    tone_check.save!

    head :ok
  end
end
