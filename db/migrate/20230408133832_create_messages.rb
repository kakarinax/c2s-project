class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.string :email, null: false
      t.string :to
      t.string :from
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
