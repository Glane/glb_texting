require 'test_helper'

class TextProviderTest < ActiveSupport::TestCase
  def setup
    @text_provider = TextProvider.new(name: "Test Provider",
                                      url: 'https://www.callback_example.com',
                                      allocation: 0.5)
  end

  test "should be valid" do
    assert @text_provider.valid?
  end

  test "name should be present" do
    @text_provider.name = "     "
    assert_not @text_provider.valid?
  end

  test "allocation should be present" do
    @text_provider.allocation = nil
    assert_not @text_provider.valid?
  end

  test "active should be online" do
    @text_provider.active = 'online'
    assert @text_provider.valid?
  end

  test 'allocation should be a number between 0 and 1' do
    @text_provider.allocation = -0.1
    assert_not @text_provider.valid?

    @text_provider.allocation = 1.1
    assert_not @text_provider.valid?

    @text_provider.allocation = 0.5
    assert @text_provider.valid?
  end

  test "load_selected_provider should return a TextProvider" do
    assert_instance_of TextProvider, TextProvider.load_selected_provider
  end

  test "reset_providers should make active providers online" do
    TextProvider.create!(name: "Tester 1", url: 'https://www.callback_example.com', allocation: 0.5, active: false)
    TextProvider.create!(name: "Tester 2", url: 'https://www.callback_example.com', allocation: 0.5, active: true)
    TextProvider.create!(name: "Tester 3", url: 'https://www.callback_example.com', allocation: 0.5, active: true)
    TextProvider.last.down!
    assert_not TextProvider.active_and_online.count == TextProvider.active.count

    TextProvider.reset_providers
    assert TextProvider.active_and_online.count == TextProvider.active.count
  end
end

