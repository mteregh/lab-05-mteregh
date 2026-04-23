class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :vet
  has_many :treatments

  enum :status, {
    scheduled: 0,
    in_progress: 1,
    completed: 2,
    cancelled: 3
  }

  validates :date, :reason, :pet, :vet, :status, presence: true

  scope :upcoming, -> { where("date > ?", Time.current).order(date: :asc) }
  scope :past, -> { where("date < ?", Time.current).order(date: :desc) }
  
end