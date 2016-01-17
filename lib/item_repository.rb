require 'pry'
require 'csv'
require 'set'
require 'bigdecimal'
require_relative 'items'

class ItemRepository

  def initialize(items)
    parse_items(items)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_items(items)
    @items_array = items.map { |row| Items.new(row) }
  end

  def all
    @items_array
  end

  def find_all_with_description(fragment)
    fragment = fragment.downcase
    @items_array.find_all do |item|
      item.description.downcase.include?(fragment)
    end
  end

  def find_all_by_price(price)
    @items_array.find_all do |item|
      # binding.pry
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items_array.find_all do |item|
      (range).member?(item.unit_price)
    end
  end

  def find_by_name(item_name)
    @items_array.find { |n| n.name.downcase == item_name.downcase}
  end

  def find_by_id(item_id)
    @items_array.find { |i| i.id == item_id}
  end

  def find_all_by_merchant_id(id)
    @items_array.select { |item| item.merchant_id == id }
  end

  def find_all_dates
    @all_invoices.map do |inv|
      inv.created_at.strftime("%A")
    end
  end

end

if __FILE__ == $0

end
