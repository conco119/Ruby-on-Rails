require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_difference 'User.count',1 do
      post users_path, params: { user: { name:  "dongmy",
       email: "user@invalid.com", password: "whatthef",
        password_confirmation: "whatthef" } }
    end
    follow_redirect!
    assert_not flash.empty?
  end
end
