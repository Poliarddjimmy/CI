# frozen_string_literal: true

# module for credit card validation
module Crypt
  extend ActiveSupport::Concern

  def self.key
    ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
  end

  def self.encrypt(text)
    key.encrypt_and_sign(text)
  end

  def self.decrypt(text)
    key.decrypt_and_verify(text)
  end
end
