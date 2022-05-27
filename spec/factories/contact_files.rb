FactoryBot.define do
  factory :contact_file do
    user { create(:user, email: Faker::Internet.email) }
    file_url { File.new("#{Rails.root}/spec/fixtures/csv/contact.csv") }
    status { "On Hold" }
  end
end
