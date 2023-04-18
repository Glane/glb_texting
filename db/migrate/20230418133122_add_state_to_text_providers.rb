class AddStateToTextProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :text_providers, :state, :string
  end
end
