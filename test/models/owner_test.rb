require "test_helper"

class OwnerTest < ActiveSupport::TestCase
  def setup
    @owner = Owner.new(
      first_name: "Maria",
      last_name: "Guerra",
      email: "maria.test@example.com",
      phone: "+56911111111",
      address: "Some address"
    )
  end

  test "valid owner can be saved" do
    assert @owner.valid?
  end

  test "first_name is required" do
    @owner.first_name = nil
    assert_not @owner.valid?
    assert_includes @owner.errors[:first_name], "can't be blank"
  end

  test "last_name is required" do
    @owner.last_name = nil
    assert_not @owner.valid?
    assert_includes @owner.errors[:last_name], "can't be blank"
  end

  test "phone is required" do
    @owner.phone = nil
    assert_not @owner.valid?
    assert_includes @owner.errors[:phone], "can't be blank"
  end

  test "email is required" do
    @owner.email = nil
    assert_not @owner.valid?
    assert_includes @owner.errors[:email], "can't be blank"
  end

  test "email must have valid format" do
    @owner.email = "not-an-email"
    assert_not @owner.valid?
    assert_not_empty @owner.errors[:email]
  end

  test "email must be unique" do
    @owner.save!
    duplicate = Owner.new(
      first_name: "Other",
      last_name: "Person",
      email: "maria.test@example.com",
      phone: "+56922222222",
      address: "Another address"
    )

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end
end