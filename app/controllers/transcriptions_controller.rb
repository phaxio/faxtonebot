class TranscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    tone_check = ToneCheck.find params[:id]

    text = params['TranscriptionText']
    if text.strip.present?
      tone_check.note = if tone_check.note.present?
        tone_check.note = "#{tone_check.note}\n\nTranscript: \"#{text}\""
      else
        text
      end

      tone_check.result = if tone_check.result.present?
        "#{tone_check.result}/Voice Detected"
      else
        'Voice Detected'
      end
    else
      tone_check.note = if tone_check.note.present?
        "#{tone_check.note}\n\nNo Voice Detected"
      else
        'No Voice Detected'
      end
    end

    tone_check.save!

    head :ok
  end
end
