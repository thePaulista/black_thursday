require 'pry'
require_relative 'sales_engine'

class Merchant
  attr_reader :id, :name, :items, :invoices

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
  end

  def specific_items(items)
    @items = items
  end

end
