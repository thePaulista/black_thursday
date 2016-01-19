require './test/test_helper'
require './lib/sales_engine'
require './lib/customer'

class CustomerTest < Minitest::Test
  @@sales_engine = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})

  def setup
    @time = Time.now.to_s
    @c = Customer.new({
      :id          => 6,
      :first_name  => "Joan",
      :last_name   => "Clarke",
      :created_at  => @time,
      :updated_at  => @time
      })
  end

  def test_customer_initializes_with_id

    assert_equal 6, @c.id
    refute_equal 7, @c.id
  end

  def test_customer_initializes_with_first_name

    assert_equal "Joan", @c.first_name
  end

  def test_customer_initializes_with_last_name

    assert_equal "Clarke", @c.last_name
    refute_equal "Joan", @c.last_name
  end

  def test_customer_initializes_with_created_at

    assert_equal Time.parse(@time), @c.created_at
  end

  def test_customer_initializes_with_updated_at

    assert_equal Time.parse(@time), @c.updated_at
  end

  def test_specific_merchants
    @@sales_engine.customer_merchants_connection
    customer = @@sales_engine.customers.find_by_id(120)
    submitted = customer.merchants

    assert_kind_of Merchant, submitted.first
    assert_equal 3, submitted.length
  end

end
