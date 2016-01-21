require 'pry'
require 'csv'
require 'set'
require 'bigdecimal'
require_relative 'invoice_item'

class InvoiceItemRepository

  def initialize(invoice_items)
    @repo = {}
    parse_invoice_items(invoice_items)
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end

  def parse_invoice_items(invoice_items)
    # @invoiceitems = invoice_items.map { |row| InvoiceItem.new(row) }
    @repo = invoice_items.each_with_object({}) do |row, hash|
      hash[row[:id]] = InvoiceItem.new(row)
    end
  end

  def all
    @all ||= @repo.map do |id, inv_item|
      merchant
    end
  end

  def find_by_id(inv_id)
    @repo[inv_id.to_s]
  end

  def find_all_by_item_id(item_id)
    # @invoiceitems.find_all { |inv_item| inv_item.item_id == item_id }
    pair = @repo.find do |id, inv_item|
      inv_item.item_id == item_id
    end
    if pair == nil
      return nil
    else
      pair[1]
    end
  end

  def find_all_by_invoice_id(invoice_id)
    # @invoiceitems.find_all { |inv_item| inv_item.invoice_id == invoice_id }
    pair = @repo.find do |id, inv_item|
      # binding.pry
      inv_item.invoice_id == invoice_id
    end
    result = []
    # binding.pry
    if pair.count > 2
      adjusted = pair.map do |pair|
        pair[1]
      end
      result = adjusted
    elsif pair.count == 2
      result = pair[1]
    end
    result
  end

end

if __FILE__ == $0
# ir = InvoiceItemRepository.new
# ir.from_csv("./data/invoice_items.csv")
# invoice = ir.find_by_id(10)
# puts invoice
end
