require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  setup do
    @text_message = TextMessage.new(
      to_number: "123-456-7890",
      message: "Hello, world!",
      callback_url: "https://example.com/callback"
    )
  end

  test "should be valid" do
    assert @text_message.valid?
  end

  test "should require a to_number" do
    @text_message.to_number = nil
    assert_not @text_message.valid?
  end

  test "should require a message" do
    @text_message.message = nil
    assert_not @text_message.valid?
  end

  test "should require a valid callback_url" do
    @text_message.callback_url = "not a url"
    assert_not @text_message.valid?
  end

  test "prepare_request should return a Net::HTTP::Post object" do
    request = @text_message.prepare_request("https://example.com")
    assert_instance_of Net::HTTP::Post, request
  end

  test 'for_number_with_invalid_status should return correct records' do
    valid_message = TextMessage.create(to_number: '8785551234', message: 'Hello!')
    invalid_message = TextMessage.create(to_number: '8785551234', message: 'Hello!')
    invalid_message.number_invalid!

    results = TextMessage.for_number_with_invalid_status('8785551234')

    assert_includes [results, invalid_message], results
  end
end
