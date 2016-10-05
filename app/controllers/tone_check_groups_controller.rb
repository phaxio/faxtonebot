require 'csv'

class ToneCheckGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = ToneCheckGroup.all
  end


  def new
    @group = ToneCheckGroup.new
  end

  def show
    @group = ToneCheckGroup.find(params[:id])
    @title = @group.name

    respond_to do |format|
      format.html
      format.csv { send_data @group.to_csv, filename: "group-#{@group.id}.csv" }
    end

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

  def destroy
    @group = ToneCheckGroup.find(params[:id])
    @group.destroy

    flash[:notice] = "Deleted group successfully."

    redirect_to tone_check_groups_path
  end

  def tone_check_group_params
    params.require(:tone_check_group).permit(:name)
  end

  def recheck
    @group = ToneCheckGroup.find(params[:id])

    @group.tone_checks.each do |check|
      check.status = :queued
      check.save

      check.delay.run_check
    end

    flash[:notice] = "Submitted all calls in group for recheck"
    redirect_to tone_check_group_path(@group)
  end
end
