# frozen_string_literal: true

require 'csv'
# job class for creating a contact
class CreateContactJob < ApplicationJob
  queue_as :default

  retry_on RuntimeError, queue: :default, attempts: 3

  def self.perform(contact_file, file)
    file_added = 0
    file_added += 1 if CSV.read(file.path).length == 1

    CSV.foreach(file, headers: true) do |row|
      new_contact = Contact.new(
        name: row['name'],
        dob: row['dob'],
        phone: row['phone'],
        address: row['address'],
        credit_card: row['credit_card'],
        email: row['email']
      )
      new_contact.user = contact_file.user
      if new_contact.save
        file_added += 1
      else
        failed = FailedContact.new(
          name: row['name'],
          dob: row['dob'],
          phone: row['phone'],
          address: row['address'],
          credit_card: row['credit_card'],
          email: row['email']
        )
        failed.user = contact_file.user
        failed.failed_reason = new_contact.errors.full_messages.join(', ')
        failed.save
      end
      contact_file.update(status: 'Processing')
    end

    case file_added
    when 0
      contact_file.update(status: 'Failed')
    else
      contact_file.update(status: 'Terminated')
    end
  end
end
