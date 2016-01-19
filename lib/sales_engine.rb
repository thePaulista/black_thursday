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
  attr_reader :csv_repo, :merchants, :items, :invoices,
              :invoice_items, :transactions, :customers

  def initialize(csv_repo)
    @csv_repo = csv_repo
    @merchants = MerchantRepository.new(@csv_repo[:merchants])
    @items = ItemRepository.new(@csv_repo[:items])
    @invoices = InvoiceRepository.new(@csv_repo[:invoices])
    @invoice_items = InvoiceItemRepository.new(@csv_repo[:invoice_items])
    @transactions = TransactionRepository.new(@csv_repo[:transactions])
    @customers = CustomerRepository.new(@csv_repo[:customers])
    relationships
  end

  def self.from_csv(file_path)
    @csv_files = {}
    file_path.each do |key, value|
      csv_file = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file.map { |row| row.to_h }
    end
    SalesEngine.new(@csv_files)
  end

  def relationships
    merchant_items_connection
    item_merchant_connection
    merchant_invoices_connection
    invoice_merchant_connection
    invoice_items_connection
    invoice_transactions_connection
    invoice_customer_connection
    transaction_invoice_connection
    merchant_customers_connection
    customer_merchants_connection
  end

  def merchant_items_connection
    merchants.all.map do |merchant|
      merchant_items = items.find_all_by_merchant_id(merchant.id)
      merchant.specific_items(merchant_items)
    end
  end

  def item_merchant_connection
    items.all.map do |item|
      items_offered = merchants.find_by_id(item.merchant_id)
      item.specific_merchant(items_offered)
    end
  end

  def merchant_invoices_connection
    merchants.all.map do |merchant|
      merchant_invoices = invoices.find_all_by_merchant_id(merchant.id)
      merchant.specific_invoices(merchant_invoices)
    end
  end

  def invoice_merchant_connection
    invoices.all.map do |invoice|
      merchant = merchants.find_by_id(invoice.merchant_id)
      invoice.specific_merchant(merchant)
    end
  end

  def invoice_items_connection
    invoices.all.map do |invoice|
      invoice_item_check = invoice_items.find_all_by_invoice_id(invoice.id)
      items_offered = invoice_item_check.each.map do |inv_item|
        items.find_by_id(inv_item.item_id)
      end
      invoice.specific_items(items_offered)
    end
  end

  def invoice_transactions_connection
    invoices.all.map do |invoice|
      invoice_transactions = transactions.find_all_by_invoice_id(invoice.id)
      invoice.specific_transactions(invoice_transactions)
    end
  end

  def invoice_customer_connection
    invoices.all.map do |invoice|
      invoice_customer = customers.find_by_id(invoice.customer_id)
      invoice.specific_customer(invoice_customer)
    end
  end

  def transaction_invoice_connection
    trans_invoices = transactions.all.map do |transaction|
      transaction_invoice = invoices.find_by_id(transaction.invoice_id)
      transaction.specific_invoice(transaction_invoice)
    end
  end

  def merchant_customers_connection
    merchants.all.map do |merchant|
      invoice_check = invoices.find_all_by_merchant_id(merchant.id)
      merchant_customers = invoice_check.each.map do |invoice|
        customers.find_by_id(invoice.customer_id)
      end
      merchant.specific_customers(merchant_customers)
    end
  end

  def customer_merchants_connection
    customers.all.map do |customer|
      invoice_check = invoices.find_all_by_customer_id(customer.id)
      customer_merchant = invoice_check.each.map do |invoice|
        merchants.find_by_id(invoice.merchant_id)
      end
      customer.specific_merchants(customer_merchant)
    end
  end

end

if __FILE__ == $0
engine = SalesEngine.from_csv({:merchants     => './data/merchants.csv',
                               :items         => './data/items.csv',
                               :invoices      => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :transactions  => './data/transactions.csv',
                               :customers     => './data/customers.csv'})

merchant = engine.merchants.find_by_id(12334194)
puts merchant.customers
puts merchant.customers.first.class
puts merchant.customers.length
end
