class TranscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Rails.logger.error "NEW TRANSCRIPTION!"
    Rails.logger.error params.inspect
    head :ok
  end
end
