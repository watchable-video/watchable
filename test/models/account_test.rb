require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should create account" do
    assert_difference "Account.count", +1 do
      Account.create!(cloudkit_id: "cloudkit_id", google_code: "google_code")
    end
  end
end
