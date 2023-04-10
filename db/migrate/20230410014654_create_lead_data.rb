class CreateLeadData < ActiveRecord::Migration[6.1]
  def change
    create_table :lead_data, id: :uuid do |t|
      t.references :message, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :phone
      t.string :client_message
      t.string :vehicle
      t.string :vehicle_year
      t.string :vehicle_link
      t.string :vehicle_price
      t.timestamps
    end
  end
end
