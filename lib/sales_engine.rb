require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repo'
require_relative 'customer_repository'
require 'pry'
require 'csv'
require 'bigdecimal'
require 'time'


class SalesEngine
  attr_reader :csv_repo
  # attr_accessor :items

  def initialize(csv_repo)
    @csv_repo = csv_repo
  end

  def self.from_csv(file_path)
    @csv_files = {}
    file_path.each do |key, value|
      csv_file_object = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file_object.map { |row| row.to_h }
    end
    SalesEngine.new(@csv_files)
  end

  def merchants
    MerchantRepository.new(@csv_repo[:merchants])
  end

  def items
    ItemRepository.new(@csv_repo[:items])
  end

  def invoices
    InvoiceRepository.new(@csv_repo[:invoices])
  end

  def invoice_items
    InvoiceItemRepository.new(@csv_repo[:invoice_items])
  end

  def transactions
    TransactionRepository.new(@csv_repo[:transactions])
  end

  def customers
    CustomerRepository.new(@csv_repo[:customers])
  end

end

if __FILE__ == $0
sales_engine = SalesEngine.from_csv({:merchants     => './data/merchants.csv',
                                     :items         => './data/items.csv',
                                     :invoices      => './data/invoices.csv',
                                     :invoice_items => './data/invoice_items.csv',
                                     :transactions  => './data/transactions.csv',
                                     :customers     => './data/customers.csv'})

item_repo = sales_engine.items
item = item_repo.find_by_name("510+ RealPush Icon Set")
puts item

merch_repo = sales_engine.merchants
merchant = merch_repo.find_by_id(12335971)
puts merchant.items

item = sales_engine.items.find_by_id(263395237)
# item.merchant

merch_repo = sales_engine.merchants
merchant = merch_repo.find_by_id(12334144)
# merchant.invoices

invoice_repo = sales_engine.invoices
invoice = invoice_repo.find_by_id(1)
# invoice.merchant

###ADD THE REST
end
