require 'pry'
require_relative 'sales_engine'

class Merchant
  # attr_accessor :id, :name, :items, :invoices, :customers
  attr_reader :id, :name, :items, :invoices

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
  end

  def items

  end

  # def items
  #   binding.pry
  #   # sales_engine = SalesEngine.from_csv({:items => './data/items.csv'})
  #   puts "this is a test"
  #   # find_all_by_merchant_id(@id).to_a
  # end
  #
  # def invoices
  #   sales_engine = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
  #   return sales_engine.invoices.find_all_by_merchant_id(@id).to_a
  # end

end
