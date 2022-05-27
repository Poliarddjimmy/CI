json.extract! contact_file, :id, :user_id, :file_url, :status, :created_at, :updated_at
json.url contact_file_url(contact_file, format: :json)
json.file_url url_for(contact_file.file_url)
