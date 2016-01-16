require 'pry'
require 'csv'
require 'set'
require_relative 'invoice'

class InvoiceRepository

  def initialize(invoices)
    parse_invoices(invoices)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_invoices(invoices)
    @invoice_array = invoices.map { |row| Invoice.new(row) }
  end

  def all
    @invoice_array
  end

  def find_by_id(invoice_id)
    @invoice_array.find { |i| i.id == invoice_id}
  end

  def find_all_by_customer_id(customer_id)
    @invoice_array.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoice_array.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoice_array.find_all do |invoice|
      invoice.status == status
    end
  end

end

if __FILE__ == $0

end
