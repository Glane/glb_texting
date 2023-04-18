class CreateTextMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :text_messages do |t|
      t.string :to_number
      t.text :message
      t.string :message_id
      t.string :status

      t.timestamps
    end
  end
end
