require 'pry'

class Merchant
  attr_accessor :id, :name

  def initialize(args_hash)
    @id = args_hash[:id].to_i
    @name = args_hash[:name]
  end

  def invoices
    sales_engine = SalesEngine.from_csv({:invoices => './data/invoices.csv'})
    puts sales_engine.invoices.find_all_by_merchant_id(@id).to_a
  end

end
