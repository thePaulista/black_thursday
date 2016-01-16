require './test/test_helper'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @i = InvoiceItem.new({
      :id          => 1,
      :item_id     => 263519844,
      :invoice_id  => 1,
      :quantity    => 5,
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time,
      :updated_at  => @time,
    })
    #1,263519844,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
  end

  def test_invoice_item_initializes_with_id
    assert_equal 1, @i.id
  end

  def test_invoice_item_initializes_with_item_id
    assert_equal 263519844, @i.item_id
  end

  def test_invoice_item_initializes_with_invoice_id
    assert_equal 1, @i.invoice_id
  end

  def test_invoice_item_initializes_with_quantity
    assert_equal 5, @i.quantity
  end

  def test_invoice_item_initializes_with_unit_price
    unit_price  = BigDecimal.new(10.99,4)
    assert_equal unit_price, @i.unit_price
  end

  def test_invoice_item_initializes_with_created_at
    assert_equal Time.parse(@time), @i.created_at
  end
end
#
#
# RSpec.describe "Iteration 3" do
#   context "Invoice Items" do
#     it "#all returns an array of all invoice item instances" do
#       expected = engine.invoice_items.all
#       expect(expected.count).to eq 21830
#     end
#
#     it "#find_by_id finds an invoice_item by id" do
#       id = 10
#       expected = engine.invoice_items.find_by_id(id)
#
#       expect(expected.id).to eq id
#       expect(expected.item_id).to eq 263523644
#       expect(expected.invoice_id).to eq 2
#     end
#
#     it "#find_by_id returns nil if the invoice item does not exist" do
#       id = 200000
#       expected = engine.invoice_items.find_by_id(id)
#
#       expect(expected).to eq nil
#     end
#
#     it "#find_all_by_item_id finds all items matching given item_id" do
#       item_id = 263408101
#       expected = engine.invoice_items.find_all_by_item_id(item_id)
#
#       expect(expected.length).to eq 11
#       expect(expected.first.class).to eq InvoiceItem
#     end
#
#     it "#find_all_by_item_id returns an empty array if there are no matches" do
#       item_id = 10
#       expected = engine.invoice_items.find_all_by_item_id(item_id)
#
#       expect(expected.length).to eq 0
#       expect(expected.empty?).to eq true
#     end
#
#     it "#find_all_by_invoice_id finds all items matching given item_id" do
#       invoice_id = 100
#       expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)
#
#       expect(expected.length).to eq 3
#       expect(expected.first.class).to eq InvoiceItem
#     end
#
#     it "#find_all_by_invoice_id returns an empty array if there are no matches" do
#       invoice_id = 1234567890
#       expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)
#
#       expect(expected.length).to eq 0
#       expect(expected.empty?).to eq true
#     end
#   end
