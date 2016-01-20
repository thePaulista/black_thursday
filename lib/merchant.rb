require 'pry'
require_relative 'sales_engine'

class Merchant
  attr_reader :id, :name, :items, :invoices,
              :customers, :revenue

  def inspect
    "#<#{self.class}>"
  end

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
  end

  def specific_items(items)
    @items = items
  end

  def specific_invoices(invoices)
    @invoices = invoices
  end

  def specific_customers(customers)
    @customers = customers
  end

  def revenue(revenue)
    @revenue = revenue
  end

end
