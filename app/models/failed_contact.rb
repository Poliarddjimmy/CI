# frozen_string_literal: true

# Failed Contact model
class FailedContact < ApplicationRecord
  self.table_name = "contacts"

  include ValidCreditCard
  include Crypt
  belongs_to :user

  after_validation :set_franchise, :encrypt_credit_card

  def last_4
    self.credit_card = Crypt.decrypt(self.credit_card)
    self.credit_card.split(//).last(4).join
  end

  private

  def set_franchise
    data = ValidCreditCard.validate(self.credit_card)
    self.errors.add(:base, 'The credit card is invalid') if data.nil?

    self.franchise = data
  end

  def encrypt_credit_card
    self.credit_card = Crypt.encrypt(self.credit_card)
  end
end
