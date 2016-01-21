require 'pry'
require_relative 'sales_engine'

class Merchant
  attr_reader :id, :name, :items, :created_at, :invoices,
              :customers

  def inspect
    "#<#{self.class}>"
  end

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
    @created_at = Time.parse(args_hash[:created_at])
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

  def specific_invoice_items
    confirmed_inv_ids = @invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def total_revenue
    total = @invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
    total.inject(0) { |sum, invoice| sum + invoice.total }
  end

end
