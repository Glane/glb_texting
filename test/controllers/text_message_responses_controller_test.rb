require 'test_helper'

class TextMessageResponsesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get text_message_responses_create_url
    assert_response :success
  end

end
