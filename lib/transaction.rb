require 'time'
require 'date'

class Transaction
  attr_accessor :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :unit_price, :created_at, :updated_at

  def initialize(args_hash)
    @id                 = args_hash[:id].to_i
    @invoice_id         = args_hash[:invoice_id].to_i
    @credit_card_number = args_hash[:credit_card_number].to_i

    # date?
    @credit_card_expiration_date = args_hash[:credit_card_expiration_date]

    # if args_hash[:unit_price].is_a?(BigDecimal)
    #   @unit_price = args_hash[:unit_price]
    # else
    #   @unit_price = BigDecimal.new(args_hash[:unit_price].insert(-3, "."),4)
    # end

    @result     = args_hash[:result]
    @created_at = Time.parse(args_hash[:created_at])
    @updated_at = Time.parse(args_hash[:updated_at])
  end
end


  # id - returns the integer id
  # invoice_id - returns the invoice id
  # credit_card_number - returns the credit card number
  # credit_card_expiration_date - returns the credit card expiration date
  # result - the transaction result
  # created_at - returns a Time instance for the date the transaction was first created
  # updated_at - returns a Time instance for the date the transaction was last modified
