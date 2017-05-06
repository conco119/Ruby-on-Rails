require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :hd
    @user2 = users :nt
  end

  test "edit when not logged in" do
    get edit_user_path @user
    assert flash.present?
    assert_redirected_to login_path
  end

  test "redirect when not logged in" do
    patch user_path(@user), params: {user: {name: "caudien", email: "nguyen hai duy"}}
    assert flash.present?
    assert_redirected_to login_path
  end

  test "should redirect destroy when not log in" do
    assert_no_difference "User.count" do
      delete user_path @user
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when not admin user" do

  end
end
