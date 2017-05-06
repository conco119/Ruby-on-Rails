require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :hd
  end

  test "update invalid infomation" do
    get edit_user_path @user
    log_in_as @user
    #assert_redirected_to edit_user_path @user
    follow_redirect!
    assert_template "users/edit"
    patch user_path(@user), params: {user: {name: "", email: "vd@gmail.com",
      password: "12345678", password_confirmation: "123"}}
    assert_template "users/edit"
  end

  test "success edit" do
    log_in_as @user
    get edit_user_path @user
    assert_template "users/edit"
    name = "NGUYEN HAI DUY"
    email = "caudien@gmail.com"
    patch user_path(@user), params: {user: {name: name},
      email: email, password: "", password_confirmation: ""}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal  name, @user.name
    assert_equal  email, @user.email
  end

end
