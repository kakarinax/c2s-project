class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :from
      t.string :to
      t.text :body
      t.string :email
      t.string :file_name
      t.binary :file_data

      t.timestamps
    end
  end
end
