require 'test_helper'

class TextMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get text_messages_create_url
    assert_response :success
  end

end
