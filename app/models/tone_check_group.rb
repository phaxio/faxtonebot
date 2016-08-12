require 'csv'

class ToneCheckGroup < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  has_many :tone_checks, -> { order number: :asc }, dependent: :destroy

  validates :name, presence: true
  validate :validate_group

  def validate_group
    errors.add(:tone_checks, "You must have at least one tone check in a group.") if tone_checks.empty?
  end

  def complete?
    status == :complete
  end

  def status
    in_progress_checks = tone_checks.select do |check|
      !check.complete?
    end

    in_progress_checks.empty? ? :complete : :in_progress
  end

  def status_class
    status == :complete ? 'success' : 'primary'
  end

  def text_report
    line_format = "%-15s     %-10s     %-s\n"

    result = sprintf(line_format, "Number", "Result", "Notes")
    result += sprintf(line_format, "=" * 15, "=" * 10, "=" * 15)

    tone_checks.each do |check|
      result += sprintf(line_format, check.number, check.result, check.note)
    end

    result
  end

  def to_csv
    attributes = %w{number result note}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      tone_checks.each do |check|
        csv << attributes.map{ |attr| check.send(attr) }
      end
    end
  end
end
