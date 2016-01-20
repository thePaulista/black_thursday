require './test/test_helper'
require './lib/merchant'
require './lib/items'
require './lib/invoice'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
  @@sales_engine = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})

  @@merchant = Merchant.new({:id => 12334195, :name => "Turing School"})

  def test_inputs_are_name_and_id
    assert_equal 12334195, @@merchant.id
    assert_equal "Turing School", @@merchant.name
  end

  def test_specific_items
    @@sales_engine.merchant_items_connection
    merchant = @@sales_engine.merchants.find_by_id(12334195)
    submitted = merchant.items

    assert_equal 20, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Item, submitted.first
  end

  def test_specific_invoices
    @@sales_engine.merchant_invoices_connection
    merchant = @@sales_engine.merchants.find_by_id(12334195)
    submitted = merchant.invoices

    assert_equal 14, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Invoice, submitted.first
  end

  def test_specific_customers
    @@sales_engine.merchant_customers_connection
    merchant = @@sales_engine.merchants.find_by_id(12334194)
    submitted = merchant.customers

    assert_kind_of Customer, submitted.first
    assert_equal 12, submitted.length
  end

end
