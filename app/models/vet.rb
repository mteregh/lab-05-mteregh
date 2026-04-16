class Vet < ApplicationRecord
  has_many :appointments

  def full_name
    "#{first_name} #{last_name}"
  end
  
end