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
    @all_invoices = invoices.map { |row| Invoice.new(row) }
  end

  def all
    @all_invoices
  end

  def find_by_id(invoice_id)
    @all_invoices.find { |invoice| invoice.id == invoice_id}
  end

  def find_all_by_customer_id(customer_id)
    @all_invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all_invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all_invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_all_dates
    @all_invoices.map do |inv|
      inv.created_at.strftime("%A")
    end
  end

end

if __FILE__ == $0


end
