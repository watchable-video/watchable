require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should create account" do
    assert_difference "Account.count", +1 do
      Account.create!(cloudkit_id: SecureRandom.hex, google_auth_data: "google_code")
    end
  end
end
