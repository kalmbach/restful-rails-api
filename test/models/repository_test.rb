require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test "is invalid without a name" do
    assert_not Repository.new(user: users(:john)).save
  end

  test "is invalid without an user" do
    assert_not Repository.new(name: "Test").save
  end
end
