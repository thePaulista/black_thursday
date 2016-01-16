require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csv_object_of_items = CSV.open './data/invoice_items.csv', headers: true, header_converters: :symbol
    @invoice_items_repo = InvoiceItemRepository.new(csv_object_of_items)
  end

  def test_can_create_a_repo_of_invoice_items
    total_items = 21687
    first_id    = 1
    last_id     = 21687

    assert_equal total_items, @invoice_items_repo.all.count
    assert_equal first_id, @invoice_items_repo.all[0].id
    assert_equal last_id, @invoice_items_repo.all[-1].id
  end

  def test_all_items
    assert_equal 21687, @invoice_items_repo.all.count
  end

  def test_find_by_id
    expected = 1
    submitted = @invoice_items_repo.find_by_id(expected)

    assert_equal expected, submitted.id
    assert_equal 263519844, submitted.item_id
    assert_equal 1, submitted.invoice_id
  end

  def test_find_by_id_returns_nil
    expected = nil
    submitted = @invoice_items_repo.find_by_id(0)

    assert_equal expected, submitted
  end

  def test_find_all_by_item_id
    expected = 19
    item_id = 263523644
    submitted = @invoice_items_repo.find_all_by_item_id(item_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_item_id_returns_empty_array
    expected = []
    item_id = 0
    submitted = @invoice_items_repo.find_all_by_item_id(item_id)

    assert_equal expected, submitted
  end

  def test_find_all_by_invoice_id
    expected = 8
    invoice_id = 3
    submitted = @invoice_items_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_invoice_id_returns_empty_array
    expected = []
    invoice_id = 0
    submitted = @invoice_items_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted
  end

end


# def test_find_all_by_customer_id
#   customer_id = 5
#   expected = 8
#   submitted = @invoice_repo.find_all_by_customer_id(customer_id)
#
#   assert_equal expected, submitted.count
# end
#
# def test_find_all_by_merchant_id
#   merchant_id = 12336730
#   expected = 7
#   submitted = @invoice_repo.find_all_by_merchant_id(merchant_id)
#
#   assert_equal expected, submitted.count
# end
#
# def find_all_by_status
#   status = :pending
#   expected = 7
#   submitted = @invoice_repo.find_all_by_status(status)
#
#   assert_equal expected, submitted.count
# end
# end

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
