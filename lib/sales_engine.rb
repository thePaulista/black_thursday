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
    merchant_items_connection
    item_merchant_connection
    merchant_invoices_connection
    invoice_merchant_connection
    invoice_items_connection
  end

  def self.from_csv(file_path)
    @csv_files = {}
    file_path.each do |key, value|
      csv_file = CSV.open value, headers: true, header_converters: :symbol
      @csv_files[key] = csv_file.map { |row| row.to_h }
    end
    SalesEngine.new(@csv_files)
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
    # we map through invoices to collect connected invoice_items

    # we map through invoice_items to collect item_ids

    # we map through invoices and match item_ids on invoice.specific_items(item_ids)

    invoice_items_that_match = invoices.all.map do |invoice|
      invoice_items.find_all_by_invoice_id(invoice.id)
    end

    invoice_items_that_match.flatten!

    invoice_items_that_match.map do |inv_item|
      final_item = items.find_by_id(inv_item.item_id)
      binding.pry
      invoices.all.map do |invoice|
        invoice.specific_items(final_item)
      end
    end
  end

  # def invoice_items_connection
  #   invoices.all.map do |invoice|
  #     invoice_item_check = invoice_items.find_all_by_invoice_id(invoice.id)
  #     invoice_item_check.map do |inv_item|
  #       items_offered = items.find_by_id(inv_item.item_id)
  #       invoice.specific_items(items_offered)
  #     end
  #   end
  # end

end

if __FILE__ == $0
engine = SalesEngine.from_csv({:merchants     => './data/merchants.csv',
                               :items         => './data/items.csv',
                               :invoices      => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :transactions  => './data/transactions.csv',
                               :customers     => './data/customers.csv'})

# merchant = engine.merchants.find_by_id(12335971)
merchant = engine.merchants.find_by_id(12334195)
merchant.items
puts merchant.items.count

item = engine.items.find_by_id(263538760)
expected = item.merchant
puts expected.name

invoice = engine.invoices.find_by_id(20)
puts invoice.items
end
