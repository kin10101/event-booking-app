class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy

  validates :name, :date, :location, presence: true
end
