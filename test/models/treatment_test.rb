require "test_helper"

class TreatmentTest < ActiveSupport::TestCase
  def setup
    @owner = Owner.create!(
      first_name: "Maria",
      last_name: "Guerra",
      email: "owner.treatment@example.com",
      phone: "+56911111111",
      address: "Address"
    )

    @pet = Pet.create!(
      name: "Luna",
      species: "dog",
      breed: "Labrador",
      date_of_birth: Date.new(2020, 5, 10),
      weight: 24.5,
      owner: @owner
    )

    @vet = Vet.create!(
      first_name: "Ana",
      last_name: "Rojas",
      email: "vet.treatment@vetclinic.com",
      phone: "+56944444444",
      specialization: "General Practice"
    )

    @appointment = Appointment.create!(
      pet: @pet,
      vet: @vet,
      date: Time.current + 1.day,
      reason: "Annual checkup",
      status: :scheduled
    )

    @treatment = Treatment.new(
      appointment: @appointment,
      name: "Skin Cream Application",
      medication: "Hydrocortisone Cream",
      dosage: "Apply twice daily",
      notes: "Monitor redness",
      administered_at: Time.current
    )
  end

  test "valid treatment can be saved" do
    assert @treatment.valid?
  end

  test "name is required" do
    @treatment.name = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:name], "can't be blank"
  end

  test "administered_at is required" do
    @treatment.administered_at = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:administered_at], "can't be blank"
  end

  test "appointment is required" do
    @treatment.appointment = nil
    assert_not @treatment.valid?
    assert_includes @treatment.errors[:appointment], "must exist"
  end
end