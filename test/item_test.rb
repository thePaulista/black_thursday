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
    @item = Item.new({
      :id          => 123456,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
      :merchant_id => 12334105
    })
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

  def test_specific_merchant
    @@sales_engine.item_merchant_connection
    item = @@sales_engine.items.find_by_id(263538760)
    submitted = item.merchant
  
    assert_kind_of Merchant, submitted
    assert_equal 12334812, submitted.id
    assert_equal "Blankiesandfriends", submitted.name
  end

end
