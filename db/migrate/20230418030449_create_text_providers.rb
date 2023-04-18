class CreateTextProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :text_providers do |t|
      t.string :name, null: false
      t.float :allocation, default: 0
      t.string :url, null: false
      t.boolean :active, default: true
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
