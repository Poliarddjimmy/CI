class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :dob
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :franchise, null: false
      t.string :email
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
