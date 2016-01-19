require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'
require 'date'
require 'time'

class InvoiceTest < Minitest::Test
  @@sales_engine = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})

  @@time = Time.now.to_s
  @@invoice = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 12335938,
    :status      => :pending,
    :created_at  => @@time,
    :updated_at  => @@time,
  })

  def test_invoice_kind_of?
    assert_kind_of Invoice, @@invoice
  end

  def test_invoice_initializes_with_id
    id = 6
    assert_equal id, @@invoice.id
  end

  def test_invoice_initializes_with_customer_id
    customer_id = 7
    assert_equal customer_id, @@invoice.customer_id
  end

  def test_invoice_initializes_with_merchant_id
    merchant_id = 12335938
    assert_equal merchant_id, @@invoice.merchant_id
  end

  def test_invoice_initializes_with_status
    status  = :pending
    assert_equal status, @@invoice.status
  end

  def test_item_initializes_with_created_at
    assert_equal Time.parse(@@time), @@invoice.created_at
  end

  def test_specific_merchant
    @@sales_engine.invoice_merchant_connection
    invoice = @@sales_engine.invoices.find_by_id(20)
    submitted = invoice.merchant

    assert_kind_of Merchant, submitted
    assert_equal 12336163, submitted.id
    assert_equal "RnRGuitarPicks", submitted.name
  end

  def test_specific_items
    @@sales_engine.invoice_items_connection
    invoice = @@sales_engine.invoices.find_by_id(106)
    submitted = invoice.items

    assert_kind_of Array, submitted
    assert_kind_of Item, submitted.first
    assert_equal 7, submitted.count
  end

# invoice.transactions # => [transaction, transaction]
# invoice.customer # => customer

end
