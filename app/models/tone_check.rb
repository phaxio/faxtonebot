class ToneCheck < ActiveRecord::Base
  enum status: [ :queued, :calling, :complete ]

  validates :number, presence: true, phone: true

  after_create do
    #queue a job for calling

  end
end
