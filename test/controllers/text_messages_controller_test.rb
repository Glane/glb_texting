require 'test_helper'

class TextMessagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create text message" do
    post :create, params: { text_message: { to_number: '1234567890', message: 'Hello World' } }
    assert_redirected_to text_messages_url
  end

  test "should not create text message with missing to_number" do
    post :create, params: { text_message: { message: 'Hello World' } }
    assert_response :unprocessable_entity
  end

  test "should not create text message with missing message" do
    post :create, params: { text_message: { to_number: '1234567890' } }
    assert_response :unprocessable_entity
  end
end
