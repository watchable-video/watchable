require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest

  test "should create and account" do
    post "/accounts", params: { account: {cloudkit_id: "cloudkit_id" } }
    assert_equal 302, status

    assert_difference -> { Account.count } do
      get "/accounts/save", params: {code: "code"}
      assert_response :success
    end
  end


end
