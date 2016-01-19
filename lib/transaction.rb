require 'time'
require 'date'

class Transaction
  attr_accessor :id, :invoice_id, :credit_card_number,
                :credit_card_expiration_date, :result,
                :unit_price, :created_at, :updated_at, :invoice

  def inspect
    "#<#{self.class}>"
  end

  def initialize(args_hash)
    @id                 = args_hash[:id].to_i
    @invoice_id         = args_hash[:invoice_id].to_i
    @credit_card_number = args_hash[:credit_card_number].to_i
    @credit_card_expiration_date = args_hash[:credit_card_expiration_date]
    @result     = args_hash[:result]
    @created_at = Time.parse(args_hash[:created_at])
    @updated_at = Time.parse(args_hash[:updated_at])
  end

  def specific_invoice(invoice)
    @invoice = invoice
  end
end
