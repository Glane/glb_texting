require 'test_helper'

class TextMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_message = TextMessage.new(
      id: 1,
      to_number: "123-456-7890",
      message: "Hello, world!",
      callback_url: 'http://example.com')
  end

  test "should get index" do
    get text_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_text_message_url
    assert_response :success
  end

  test "should show text_message" do
    get text_message_url(@text_message)
    assert_response :success
  end
end
