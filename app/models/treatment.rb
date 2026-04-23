class Treatment < ApplicationRecord
  belongs_to :appointment

  validates :name, :administered_at, :appointment, presence: true
end