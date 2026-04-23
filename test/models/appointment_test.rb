require "test_helper"

class AppointmentTest < ActiveSupport::TestCase
  def setup
    @owner = Owner.create!(
      first_name: "Maria",
      last_name: "Guerra",
      email: "owner.appointment@example.com",
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
      email: "vet.appointment@vetclinic.com",
      phone: "+56944444444",
      specialization: "General Practice"
    )

    @appointment = Appointment.new(
      pet: @pet,
      vet: @vet,
      date: Time.current + 1.day,
      reason: "Annual checkup",
      status: :scheduled
    )
  end

  test "valid appointment can be saved" do
    assert @appointment.valid?
  end

  test "date is required" do
    @appointment.date = nil
    assert_not @appointment.valid?
    assert_includes @appointment.errors[:date], "can't be blank"
  end

  test "reason is required" do
    @appointment.reason = nil
    assert_not @appointment.valid?
    assert_includes @appointment.errors[:reason], "can't be blank"
  end

  test "pet is required" do
    @appointment.pet = nil
    assert_not @appointment.valid?
    assert_includes @appointment.errors[:pet], "must exist"
  end

  test "vet is required" do
    @appointment.vet = nil
    assert_not @appointment.valid?
    assert_includes @appointment.errors[:vet], "must exist"
  end

  test "status is required" do
    @appointment.status = nil
    assert_not @appointment.valid?
    assert_includes @appointment.errors[:status], "can't be blank"
  end
end