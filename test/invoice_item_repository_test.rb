require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  csv_object_of_invoice_items = CSV.open './data/invoice_items.csv', headers: true, header_converters: :symbol
  @@invoice_items_repo = InvoiceItemRepository.new(csv_object_of_invoice_items)

  def test_can_create_a_repo_of_invoice_items
    total_items = 21830
    first_id    = 1
    last_id     = 21830

    assert_equal total_items, @@invoice_items_repo.all.count
    assert_equal first_id, @@invoice_items_repo.all[0].id
    assert_equal last_id, @@invoice_items_repo.all[-1].id
  end

  def test_all_items
    assert_equal 21830, @@invoice_items_repo.all.count
  end

  def test_find_by_id
    expected = 1
    submitted = @@invoice_items_repo.find_by_id(expected)

    assert_equal expected, submitted.id
    assert_equal 263519844, submitted.item_id
    assert_equal 1, submitted.invoice_id
  end

  def test_find_by_id_returns_nil
    expected = nil
    submitted = @@invoice_items_repo.find_by_id(200000)

    assert_equal expected, submitted
  end

  def test_find_all_by_item_id
    expected = 11
    item_id = 263408101
    submitted = @@invoice_items_repo.find_all_by_item_id(item_id)

    assert_equal expected, submitted.count
    assert_kind_of InvoiceItem, submitted.first
  end

  def test_find_all_by_item_id_returns_empty_array
    expected = []
    item_id = 10
    submitted = @@invoice_items_repo.find_all_by_item_id(item_id)

    assert_equal expected, submitted
    assert_equal 0, submitted.length
    assert_equal true, submitted.empty?
  end

  def test_find_all_by_invoice_id
    expected = 3
    invoice_id = 100
    submitted = @@invoice_items_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted.count
    assert_kind_of InvoiceItem, submitted.first
  end

  def test_find_all_by_invoice_id_returns_empty_array
    expected = []
    invoice_id = 0
    submitted = @@invoice_items_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted
    assert_equal 0, submitted.length
    assert_equal true, submitted.empty?
  end
end
