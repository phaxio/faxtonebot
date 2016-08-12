class ToneCheckGroupsController < ApplicationController

  def index
    @groups = ToneCheckGroup.all
  end


  def new
    @group = ToneCheckGroup.new
  end

  def create
    @group = ToneCheckGroup.new(tone_check_group_params)
    numbers_in_error = []

    @numbers = params[:numbers]
    number_strings = @numbers.split(/\n/).delete_if{ |e| e.blank? }
    number_strings.each do |number|
      if Phonelib.invalid? number
        numbers_in_error.push number
      else
        @group.tone_checks.push ToneCheck.new(number: (Phonelib.parse number).e164)
      end
    end


    if @group.valid? and numbers_in_error.empty?
      @group.save
      redirect_to tone_check_group_path(@group)
    else
      if not numbers_in_error.empty?
        @numbers_error_message = "The following numbers are not valid: " + numbers_in_error.join(', ')
      elsif @group.errors[:tone_checks]
        @numbers_error_message = @group.errors[:tone_checks][0]
      end
      render action: 'new'
    end
  end

  def tone_check_group_params
    params.require(:tone_check_group).permit(:name)
  end
end
