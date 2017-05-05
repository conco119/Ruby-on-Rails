require "test_helper"

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users :hd
    remember @user
  end
  test "login with valid user" do
    assert_equal @user, current_user
  end
  test "current_user returns nil when remember digest is wrong" do
    @user.update_attributes remember_digest: nil
    assert_nil current_user
  end
end
