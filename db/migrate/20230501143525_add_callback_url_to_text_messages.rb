class AddCallbackUrlToTextMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :text_messages, :callback_url, :string
  end
end
