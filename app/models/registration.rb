class Registration < ApplicationRecord
  belongs_to :event

  validates :attendee_name, presence: true
  validates :attendee_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :attendee_email, uniqueness: { scope: :event_id, message: "is already registered for this event" }
end
