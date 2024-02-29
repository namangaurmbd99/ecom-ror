require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm_order" do
    get checkout_confirm_order_url
    assert_response :success
  end
end
