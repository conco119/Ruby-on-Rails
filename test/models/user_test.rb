require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Nguyen hai duy", email: "Nguyenhaiduy@gmail.com",
    password: "foorbar", password_confirmation: "foobar")
  end

  test "email address should be saved as lower-case" do
    @user.email = "USER@example.com"
    @user.save
    assert_equal "user@example.com", @user.email , "Email da luu la #{@user.email}"
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
  test "something interesting" do

  end
end
