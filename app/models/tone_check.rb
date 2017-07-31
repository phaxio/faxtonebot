class ToneCheck < ActiveRecord::Base
  enum status: [ :queued, :calling, :complete ]

  belongs_to :tone_check_group
  validates :number, presence: true, phone: true

  after_create do
    self.status = :queued
    self.save!

    self.delay.run_check
  end

  def status_class
    classes = {'queued' => 'primary', 'calling' => 'info', 'complete' => 'success' }
    classes[status]
  end

  def run_check
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_AUTH_TOKEN"]
    @call = @client.calls.create(
        from: ENV["TWILIO_FROM_NUMBER"],
        to: number,
        Url: ENV["PUBLIC_HOST"] + Rails.application.routes.url_helpers.twilml_record_path(self),
        StatusCallback: ENV["PUBLIC_HOST"] + Rails.application.routes.url_helpers.tone_check_status_path(self)
    )
    self.status = :calling
    self.save!
  end
end
