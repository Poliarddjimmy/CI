# frozen_string_literal: true

# Contact model
class Contact < ApplicationRecord
  belongs_to :user
  include ValidCreditCard
  include Crypt

  NAME_REGEX = /^(?!.*[-]).*/.freeze
  BIRTHDATE_REGEX = /^\d{4}[\-\/\s]?((((0[13578])|(1[02]))[\-\/\s]?(([0-2][0-9])|(3[01])))|(((0[469])|(11))[\-\/\s]?(([0-2][0-9])|(30)))|(02[\-\/\s]?[0-2][0-9]))$/.freeze
  PHONE_REGEX = /\+?\d{0,3}\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{2}[\s.-]?\d{2}/.freeze
  CC_REGEX = /^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$/.freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true
  validates :dob, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :credit_card, presence: true

  after_validation :set_franchise, :encrypt_credit_card

  validate do |contact|
    contact.errors.add(:base, "The Name: #{contact.name} is invalid") if NAME_REGEX.match(contact.name).nil?
    contact.errors.add(:base, "Invalide email: #{contact.email}") if EMAIL_REGEX.match(contact.email).nil?
    contact.errors.add(:base, "Contact Email: #{contact.email} is already taken for this user") if Contact.where(email: contact.email, user_id: contact.user_id).exists?
    contact.errors.add(:base, "The credit card: #{contact.credit_card} is invalid") if CC_REGEX.match(contact.credit_card).nil?
    contact.errors.add(:base, "The phone number: #{contact.phone} must be at least 10 characters and connot be greater than 19") if contact.phone && contact.phone.length < 10 && contact.phone.length > 19
    contact.errors.add(:base, "The birthdate: #{contact.dob} is invalid") if BIRTHDATE_REGEX.match(contact.dob).nil?
    contact.errors.add(:base, "The phone number #{contact.phone} is invalid") if PHONE_REGEX.match(contact.phone).nil?
  end

  def last_4
    self.credit_card = Crypt.decrypt(self.credit_card)
    self.credit_card.split(//).last(4).join
  end

  private

  def set_franchise
    data = ValidCreditCard.validate(self.credit_card)
    self.errors.add(:base, "The credit card #{self.credit_card} is invalid") if data.nil?

    self.franchise = data
  end

  def encrypt_credit_card
    self.credit_card = Crypt.encrypt(self.credit_card)
  end
end
