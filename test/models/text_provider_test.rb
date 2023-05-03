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

  test "should have a load selected provider method that returns a TextProvider object" do
    total_count = 80
    provider1 = TextProvider.create(name: "Provider1", url: "https://example1.com", allocation: 0.4, count: 35, active: true, state: "online")
    provider2 = TextProvider.create(name: "Provider2", url: "https://example2.com", allocation: 0.3, count: 20, active: true, state: "online")
    provider3 = TextProvider.create(name: "Provider3", url: "https://example3.com", allocation: 0.2, count: 15, active: true, state: "online")
    provider4 = TextProvider.create(name: "Provider4", url: "https://example4.com", allocation: 0.1, count: 10, active: true, state: "offline")

    result = TextProvider.load_selected_provider
    assert_equal provider2, result

    provider1.destroy
    provider2.destroy
    provider3.destroy
    provider4.destroy
  end

  test "reset_providers should make active providers online" do
    TextProvider.create!(name: "Tester 1", url: 'https://www.callback_example.com', allocation: 0.5, active: false, state: "offline")
    TextProvider.create!(name: "Tester 2", url: 'https://www.callback_example.com', allocation: 0.5, active: true, state: "offline")
    TextProvider.create!(name: "Tester 3", url: 'https://www.callback_example.com', allocation: 0.5, active: true, state: "online")
    TextProvider.last.down!
    assert_not TextProvider.active_and_online.count == TextProvider.active.count

    TextProvider.reset_providers
    assert TextProvider.active_and_online.count == TextProvider.active.count
  end
end


