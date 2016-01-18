require 'pry'
require 'csv'
require 'set'
require 'bigdecimal'
require_relative 'invoice_item'

class InvoiceItemRepository

  def initialize(invoice_items)
    parse_invoice_items(invoice_items)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def parse_invoice_items(invoice_items)
    @invoiceitems = invoice_items.map { |row| InvoiceItem.new(row) }
  end

  def all
    @invoiceitems
  end

  def find_by_id(inv_id)
    @invoiceitems.find { |inv_item| inv_item.id == inv_id }
  end

  def find_all_by_item_id(item_id)
    @invoiceitems.find_all { |inv_item| inv_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoiceitems.find_all { |inv_item| inv_item.invoice_id == invoice_id }
  end

end

if __FILE__ == $0
# ir = InvoiceItemRepository.new
# ir.from_csv("./data/invoice_items.csv")
# invoice = ir.find_by_id(10)
# puts invoice
end
