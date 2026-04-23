require "test_helper"

class VetTest < ActiveSupport::TestCase
  def setup
    @vet = Vet.new(
      first_name: "Ana",
      last_name: "Rojas",
      email: "ana.test@vetclinic.com",
      phone: "+56944444444",
      specialization: "General Practice"
    )
  end

  test "valid vet can be saved" do
    assert @vet.valid?
  end

  test "first_name is required" do
    @vet.first_name = nil
    assert_not @vet.valid?
    assert_includes @vet.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    @vet.last_name = nil
    assert_not @vet.valid?
    assert_includes @vet.errors[:last_name], "can't be blank"
  end

  test "specialization is required" do
    @vet.specialization = nil
    assert_not @vet.valid?
    assert_includes @vet.errors[:specialization], "can't be blank"
  end

  test "email is required" do
    @vet.email = nil
    assert_not @vet.valid?
    assert_includes @vet.errors[:email], "can't be blank"
  end

  test "email must have valid format" do
    @vet.email = "invalid-email"
    assert_not @vet.valid?
    assert_not_empty @vet.errors[:email]
  end

  test "email must be unique" do
    @vet.save!
    duplicate = Vet.new(
      first_name: "Carlos",
      last_name: "Fernandez",
      email: "ana.test@vetclinic.com",
      phone: "+56955555555",
      specialization: "Surgery"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end
end