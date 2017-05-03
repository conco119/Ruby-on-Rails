require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new email: "validemail@gmail.com", password: "12345678", password_confirmation: "12345678"
  end
  test "password should be presence" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have minium length" do
    @user.password = @user.password_confirmation = "a" * 4
    assert_not @user.valid?
  end

  test "name should right" do
    @user.save
    assert_not @user.valid?
  end
end
