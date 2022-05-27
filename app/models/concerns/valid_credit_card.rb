# frozen_string_literal: true

# module for credit card validation
module ValidCreditCard
  extend ActiveSupport::Concern

  def self.validate(number)
    # check if the number is belong to masterCard
    if number.to_s.length == 16 && number.to_s.start_with?('51', '52', '53', '54', '55', '2221', '2720')
      'MasterCard'
    # check if the credit_card is belong to visa
    elsif number.to_s.length == 16 && number.to_s.start_with?('4')
      'Visa'
    # check if the credit_card is belong to amex
    elsif number.to_s.length == 15 && number.to_s.start_with?('34', '37')
      'American Express'
    # check if the credit_card is belong to discover
    elsif number.to_s.length == 16 && number.to_s.start_with?('6011', '644', '645', '646', '647', '648', '649', '65')
      'Discover'
    # check if the credit_card is belong to diners
    elsif number.to_s.length == 14 && number.to_s.start_with?('300', '301', '302', '303', '304', '305', '36', '38', '39')
      'Diners Club'
    # check if the credit_card is belong to jcb
    elsif number.to_s.length == 16 && number.to_s.start_with?('35')
      'JCB'
    else
      nil
    end
  end
end
