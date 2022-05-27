# frozen_string_literal: true

# Contact file model
class ContactFile < ApplicationRecord
  belongs_to :user
  has_attached_file :file_url

  validates_attachment :file_url, content_type: { content_type: 'text/csv' }
  validates :status, inclusion: { in: ['On Hold', 'Processing', 'Failed', 'Terminated'] }

  scope :on_hold, -> { where(status: 'On Hold') }
  scope :processing, -> { where(status: 'Processing') }
  scope :failed, -> { where(status: 'Failed') }
  scope :terminated, -> { where(status: 'Terminated') }
end
