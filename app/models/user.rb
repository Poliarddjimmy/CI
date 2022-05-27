# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_many :contacts
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validate do |user|
    user.errors.add(:base, 'Invalide email') if EMAIL_REGEX.match(user.email).nil?
    user.errors.add(:base, 'The Password must be at least 6 characters') if user.password && user.password.length < 6
    user.errors.add(:base, 'The email is Required') if user.email.blank?
    user.errors.add(:base, 'The email is already taken') if User.where(email: user.email).exists?
  end
end
