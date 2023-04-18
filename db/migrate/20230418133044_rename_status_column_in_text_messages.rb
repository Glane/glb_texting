class RenameStatusColumnInTextMessages < ActiveRecord::Migration[6.0]
  def change
    rename_column :text_messages, :status, :state
  end
end
