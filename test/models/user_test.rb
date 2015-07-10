require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "is invalid without an username" do
    assert_not User.new(email: "test@email.com").save
  end

  test "is invalid without an email" do
    assert_not User.new(username: "test").save
  end
end
