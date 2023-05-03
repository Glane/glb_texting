require 'test_helper'

class TextProvidersControllerTest < ActionController::TestCase
  setup do
    @text_provider = text_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:text_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:text_provider)
  end

  test "should create text_provider" do
    assert_difference('TextProvider.count') do
      post :create, params: { text_provider: { name: "New Provider", allocation: 0.5, active: true, count: 0, url: "http://example.com" } }
    end

    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @text_provider }
    assert_response :success
    assert_not_nil assigns(:text_provider)
  end

  test "should update text_provider" do
    patch :update_provider, params: { text_provider_id: @text_provider, text_provider: { name: "Updated Provider", allocation: 0.2, active: true, count: 10, url: "http://example.com" } }
    assert_response :success
  end

  test "should delete text_provider" do
    assert_difference('TextProvider.count', -1) do
      delete :delete_provider, params: { text_provider_id: @text_provider }
    end

    assert_response :success
  end

  private

  def text_provider_params
    { name: "New Provider", allocation: 0.5, active: true, count: 0, url: "http://example.com" }
  end
end
