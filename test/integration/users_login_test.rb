require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:hd)
  end

  test "login with remember me" do
    log_in_as @user, remember_me: "1"
    assert_equal cookies["remember_token"], assigns(:user).remember_token
  end

  test "login without remember_me" do
    log_in_as @user, remember_me: "1"
    log_in_as @user, remember_me: "0"
    assert_empty cookies["remember_token"]

  end

  test "login with vaild infomation followed by logout" do
    get login_path
    post login_path, params: {session: {email: @user.email, password: "1234567" }}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert "users/show"
    delete logout_path
    assert_redirected_to root_path
    assert_not is_logged_in?
    follow_redirect!
    assert_select "a[href=?]", login_path
    # simute a user clicking on second windows brower
    delete logout_path
  end

  test "login with invalid infomation" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {session: {email: "dm@gmail.com", password: ""}}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid infomation 2" do
    get login_path
    post login_path, params: {session: { email: "hd@gmail.com", password: "1234567" }}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "log in and log out" do
    get login_path
    post login_path, params: {session: {email: "hd@gmail.com", password: "1234567"}}
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?

  end
end
