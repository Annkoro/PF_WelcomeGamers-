class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
