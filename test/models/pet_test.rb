require "test_helper"

class PetTest < ActiveSupport::TestCase
  def setup
    @owner = Owner.create!(
      first_name: "Maria",
      last_name: "Guerra",
      email: "owner.pet@example.com",
      phone: "+56911111111",
      address: "Address"
    )

    @pet = Pet.new(
      name: "luna",
      species: "dog",
      breed: "Labrador",
      date_of_birth: Date.new(2020, 5, 10),
      weight: 24.5,
      owner: @owner
    )
  end

  test "valid pet can be saved" do
    assert @pet.valid?
  end

  test "name is required" do
    @pet.name = nil
    assert_not @pet.valid?
    assert_includes @pet.errors[:name], "can't be blank"
  end

  test "species is required" do
    @pet.species = nil
    assert_not @pet.valid?
    assert_includes @pet.errors[:species], "can't be blank"
  end

  test "species must be included in allowed list" do
    @pet.species = "horse"
    assert_not @pet.valid?
    assert_not_empty @pet.errors[:species]
  end

  test "date_of_birth is required" do
    @pet.date_of_birth = nil
    assert_not @pet.valid?
    assert_includes @pet.errors[:date_of_birth], "can't be blank"
  end

  test "date_of_birth cannot be in the future" do
    @pet.date_of_birth = Date.current + 1.day
    assert_not @pet.valid?
    assert_includes @pet.errors[:date_of_birth], "cannot be in the future"
  end

  test "weight is required" do
    @pet.weight = nil
    assert_not @pet.valid?
    assert_includes @pet.errors[:weight], "can't be blank"
  end

  test "weight must be greater than 0" do
    @pet.weight = 0
    assert_not @pet.valid?
    assert_not_empty @pet.errors[:weight]
  end

  test "owner is required" do
    @pet.owner = nil
    assert_not @pet.valid?
    assert_includes @pet.errors[:owner], "must exist"
  end
end