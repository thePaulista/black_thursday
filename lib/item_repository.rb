require 'pry'
require 'csv'
require 'bigdecimal'
require_relative 'items'

class ItemRepository

  def initialize(items)
    parse_items(items)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def parse_items(items)
    @items = items.map { |row| Item.new(row) }
  end

  def all
    @items
  end

  def find_all_with_description(fragment)
    fragment = fragment.downcase
    @items.find_all do |item|
      item.description.downcase.include?(fragment)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      # binding.pry
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      (range).member?(item.unit_price)
    end
  end

  def find_by_name(item_name)
    @items.find { |n| n.name.downcase == item_name.downcase}
  end

  def find_by_id(item_id)
    @items.find { |i| i.id == item_id}
  end

  def find_all_by_merchant_id(id)
    @items.select { |item| item.merchant_id == id }
  end

  def find_all_dates
    @all_invoices.map do |inv|
      inv.created_at.strftime("%A")
    end
  end

  # def find_created_date_by_merchant_id(id)
  #   @items.select {|item| item.created_at if item.merchant_id == id }
  #   binding.pry
  # end

end

if __FILE__ == $0

end
