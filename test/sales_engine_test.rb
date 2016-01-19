require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  @@sales_engine = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})

  def test_to_create_a_sales_engine_object_we_use_the_factory
    assert_kind_of SalesEngine, @@sales_engine
  end

  def test_sales_engine_can_create_Merchant_Repos
    merch_repo = @@sales_engine.merchants
    expected = "#<Merchant:0"
    submitted = merch_repo.find_by_name("CJsDecor").to_s

    assert submitted.include?(expected)
    assert_kind_of MerchantRepository, merch_repo
  end

  def test_sales_engine_can_create_Items_Repos
    item_repo = @@sales_engine.items
    expected = "#<Items:0"
    submitted = item_repo.find_by_name("510+ RealPush Icon Set").to_s

    assert submitted.include?(expected)
    assert_kind_of ItemRepository, item_repo
  end

  def test_sales_engine_can_create_Items_Repos
    item_repo = @@sales_engine.invoices
    expected = "#<Invoice:0"
    submitted = item_repo.find_by_id(1).to_s

    assert submitted.include?(expected)
    assert_kind_of InvoiceRepository, item_repo
  end

end
