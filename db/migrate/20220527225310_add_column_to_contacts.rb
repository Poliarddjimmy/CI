class AddColumnToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :failed_reason, :string, default: nil
  end
end
