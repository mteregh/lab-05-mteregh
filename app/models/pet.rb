class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments

  validates :name, :species, :date_of_birth, :weight, :owner, presence: true
  validates :species, inclusion: { in: %w[dog cat rabbit bird reptile other] }
  validates :weight, numericality: { greater_than: 0 }

  validate :date_of_birth_cannot_be_in_future

  before_save :capitalize_name

  scope :by_species, ->(species) { where(species: species) }
  
  private

  def date_of_birth_cannot_be_in_future
    return if date_of_birth.blank?

    errors.add(:date_of_birth, "cannot be in the future") if date_of_birth > Date.current
  end

  def capitalize_name
    self.name = name.to_s.capitalize
  end
end