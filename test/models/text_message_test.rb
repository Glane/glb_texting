class TextMessageTest < ActiveSupport::TestCase
  def setup
    @text_message = TextMessage.new(to_number: '8785551234', message: 'Hello!')
  end

  test 'should be valid' do
    assert @text_message.valid?
  end

  test 'should require to_number' do
    @text_message.to_number = ''
    assert_not @text_message.valid?
  end

  test 'should require message' do
    @text_message.message = ''
    assert_not @text_message.valid?
  end

  test 'for_number_with_invalid_status should return correct records' do
    valid_message = TextMessage.create(to_number: '8785551234', message: 'Hello!')
    invalid_message = TextMessage.create(to_number: '8785551234', message: 'Hello!')
    invalid_message.number_invalid!

    results = TextMessage.for_number_with_invalid_status('8785551234')

    assert_includes [results, invalid_message], results
  end
end
