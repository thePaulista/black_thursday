require 'pry'
require 'csv'
require 'set'
require 'bigdecimal'
require_relative 'invoice_item'

class InvoiceItemRepository

  # def initialize(invoice_items)
  #   parse_invoice_items(invoice_items)
  # end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def from_csv(file)
    csv_file = CSV.open file, headers: true, header_converters: :symbol
    pre_parse = csv_file.map { |row| row.to_h }
    parse_invoice_items(pre_parse)
    # parse_invoice_items(csv_file.map { |row| row.to_h })
  end

  def parse_invoice_items(invoice_items)
    @invoice_items_array = invoice_items.map { |row| InvoiceItem.new(row) }
  end

  def all
    @invoice_items_array
  end

  def find_by_id(inv_id)
    @invoice_items_array.find { |inv_item| inv_item.id == inv_id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items_array.find_all { |inv_item| inv_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items_array.find_all { |inv_item| inv_item.invoice_id == invoice_id }
  end

end

if __FILE__ == $0
ir = InvoiceItemRepository.new
ir.from_csv("./data/invoice_items.csv")
invoice = ir.find_by_id(10)
puts invoice
end
