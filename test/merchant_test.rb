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

  def setup
    @merchant = Merchant.new({:id => 12335971, :name => "Turing School"})
  end

  def test_inputs_are_name_and_id
    assert_equal 12335971, @merchant.id
    assert_equal "Turing School", @merchant.name
  end

  def test_items
    skip
    merchant_id = @merchant.id
    submitted = @sales_engine.items.find_all_by_merchant_id(merchant_id).to_a

    assert_equal 1, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Items, submitted.first
  end

  def test_invoices
    skip
    merchant_id = @merchant.id
    submitted = @sales_engine.invoices.find_all_by_merchant_id(merchant_id).to_a

    assert_equal 14, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Invoice, submitted.first
  end
end
