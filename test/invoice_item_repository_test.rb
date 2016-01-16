require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_items_repo = InvoiceItemRepository.new
    @invoice_items_repo.from_csv("./data/invoice_items.csv")
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
    submitted = @invoice_items_repo.find_by_id(200000)

    assert_equal expected, submitted
  end

  def test_find_all_by_item_id
    expected = 11
    item_id = 263408101
    submitted = @invoice_items_repo.find_all_by_item_id(item_id)

    assert_equal expected, submitted.count
    assert_kind_of InvoiceItem, submitted.first
  end

  def test_find_all_by_item_id_returns_empty_array
    expected = []
    item_id = 10
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
