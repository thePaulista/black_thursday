require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @invoice_item = InvoiceItem.new({
      :id          => 1,
      :item_id     => 263519844,
      :invoice_id  => 1,
      :quantity    => 5,
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => @time,
      :updated_at  => @time,
    })
    #1,263519844,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
  end

  def test_invoice_item_initializes_with_id
    assert_equal 1, @invoice_item.id
  end

  def test_invoice_item_initializes_with_item_id
    assert_equal 263519844, @invoice_item.item_id
  end

  def test_invoice_item_initializes_with_invoice_id
    assert_equal 1, @invoice_item.invoice_id
  end

  def test_invoice_item_initializes_with_quantity
    assert_equal 5, @invoice_item.quantity
  end

  def test_invoice_item_initializes_with_unit_price
    unit_price  = BigDecimal.new(10.99,4)
    assert_equal unit_price, @invoice_item.unit_price
  end

  def test_invoice_item_initializes_with_created_at
    assert_equal Time.parse(@time), @invoice_item.created_at
  end

  def test_invoice_item_initializes_with_updated_at
    assert_equal Time.parse(@time), @invoice_item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
  end
end
