class ToneChecksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def status
    @tone_check = ToneCheck.find(params[:id])

    if !@tone_check
      render text: "Could not find tone check with id #{params[:id]}, but that's ok.  We'll just assume it was deleted."
    else
      @tone_check.audio_url = params['RecordingUrl']
      @tone_check.status = :complete

      line_error_types = {'no-answer' => 'No answer', "busy" => "Busy", "failed" => "Failed/Not in service"}

      if line_error_types.has_key?(params['CallStatus'])
        @tone_check.result = line_error_types[params['CallStatus']]
      end

      @tone_check.save
    end

    render text: "success!"
  end

  def recheck
    @tone_check = ToneCheck.find(params[:id])
    @tone_check.run_check

    flash[:notice] = "Rechecking #{@tone_check.number}..."

    redirect_to tone_check_group_path(@tone_check.tone_check_group)
  end

  def update
    @tone_check = ToneCheck.find(params[:id])

    if not @tone_check.update(tone_check_params)
      flash[:alert] = "Could not update tone check"
    end

    redirect_to tone_check_group_path(@tone_check.tone_check_group)
  end

  def show
    @tone_check = ToneCheck.find(params[:id])
    render json: @tone_check
  end

  def tone_check_params
    params.require(:tone_check).permit(:note, :result)
  end

end
