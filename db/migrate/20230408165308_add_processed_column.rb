class AddProcessedColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :processed, :boolean, default: false
  end
end
