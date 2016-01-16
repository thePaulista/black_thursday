require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    csv_object_of_items = CSV.open './data/invoices.csv', headers: true, header_converters: :symbol
    @invoice_repo = InvoiceRepository.new(csv_object_of_items)
  end

  def test_can_create_a_repo_of_items
    total_items = 4985
    first_id    = 1
    last_id     = 4985

    assert_equal total_items, @invoice_repo.all.count
    assert_equal first_id, @invoice_repo.all[0].id
    assert_equal last_id, @invoice_repo.all[-1].id
  end

  def test_all_items
    total_items = 4985

    assert_equal total_items, @invoice_repo.all.count
  end

  def test_find_by_id
    expected_1 = 1
    expected_2 = 86
    submitted_1 = @invoice_repo.find_by_id(expected_1)
    submitted_2 = @invoice_repo.find_by_id(expected_2)

    assert_equal expected_1, submitted_1.id
    assert_equal expected_2, submitted_2.id
  end
end
