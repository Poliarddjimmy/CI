# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    name { 'MyString' }
    dob { '1988/04/23' }
    phone { '(+59)320-432-05-09' }
    address { 'MyString' }
    credit_card { '4242424242424242' }
    email { 'email@gmail.com' }
    user { create(:user, email: Faker::Internet.email) }
    franchise { 'Visa' }
  end
end
