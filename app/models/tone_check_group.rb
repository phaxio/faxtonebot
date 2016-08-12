class ToneCheckGroup < ActiveRecord::Base
  default_scope { order(created_at: :desc) }

  has_many :tone_checks, -> { order number: :asc }, dependent: :destroy

  validates :name, presence: true
  validate :validate_group

  def validate_group
    errors.add(:tone_checks, "You must have at least one tone check in a group.") if tone_checks.empty?
  end

  def status
    in_progress_checks = tone_checks.select do |check|
      check.status != :complete
    end

    in_progress_checks.empty? ? :complete : :in_progress
  end

  def status_class
    status == :complete ? 'success' : 'primary'
  end

end
