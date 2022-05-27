class CreateContactFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_files do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.attachment :file_url, null: false
      t.string :status, null: false, default: 'On Hold'

      t.timestamps
    end
  end
end
