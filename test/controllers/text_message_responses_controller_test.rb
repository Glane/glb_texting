require 'test_helper'

class TextMessageResponsesControllerTest < ActionController::TestCase
  test 'should update text message status' do
    text_message = TextMessage.create(to_number: '1234567890', message: 'Hello World', callback_url: 'https://happy.com')
    text_message.message_id = '222'
    text_message.save
    post :create, params: { text_message_response: { status: 'delivered', message_id: '222' } }
    text_message.reload
    assert_equal 'delivered', text_message.state
  end

  test 'should update text message status to number_invalid' do
    text_message = TextMessage.create(to_number: '1234567890', message: 'Hello World', callback_url: 'https://happy.com')
    text_message.message_id = '333'
    text_message.save
    post :create, params: { text_message_response: { status: 'invalid', message_id: '333' } }
    text_message.reload
    assert_equal 'number_invalid', text_message.state
  end
end

