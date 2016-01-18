require './test/test_helper'
require './lib/sales_engine'
require './lib/items'

class ItemTest < Minitest::Test
  @@sales_engine = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})

  def setup
    @time = Time.now.to_s
    @item = Items.new({
      :id          => 123456,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 12334105
    })
    # @sales_engine = SalesEngine.from_csv({
    #   :merchants     => './data/merchants.csv',
    #   :items         => './data/items.csv',
    #   :invoices      => './data/invoices.csv',
    #   :invoice_items => './data/invoice_items.csv',
    #   :transactions  => './data/transactions.csv',
    #   :customers     => './data/customers.csv'})
  end

  def test_item_initializes_with_id
    assert_equal 123456, @item.id
  end

  def test_item_initializes_with_name
    assert_equal "Pencil", @item.name
  end

  def test_item_initializes_with_description
    description = "You can use it to write things"
    assert_equal description, @item.description
  end

  def test_item_initializes_with_unit_price
    unit_price  = BigDecimal.new(10.99,4)
    assert_equal unit_price, @item.unit_price
  end

  def test_item_initializes_with_created_at
    assert_equal Time.parse(@time), @item.created_at
  end

  def test_item_initializes_with_updated_at
    assert_equal Time.parse(@time), @item.updated_at
  end

  def test_merchant
    skip
    merchant_id = @item.merchant_id
    submitted = @sales_engine.merchants.find_by_id(merchant_id)

    assert submitted.to_s.include?("Merchant:0")
    assert_kind_of Merchant, submitted
  end

end
