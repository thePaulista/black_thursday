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

  def test_find_by_name_case_insensitve_search
    skip
    item_name = "510+ RealPush Icon Set"
    expected  = item_name
    submitted = @ir.find_by_name(item_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_incomplete_name
    skip
    item_name = "510+"
    expected  = item_name
    submitted = @ir.find_by_name(item_name.upcase)

    assert_nil submitted
  end

  def test_find_by_name_rejects_bad_name
    skip
    item_name = "BurgerKing"
    submitted = @ir.find_by_name(item_name)

    assert_nil submitted
  end

  def test_find_by_given_item_id
    skip
    item_id   = 263395237
    expected  = item_id
    submitted = @ir.find_by_id(item_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    skip
    item_id   = 1
    expected  = item_id
    submitted = @ir.find_by_id(item_id)

    assert_nil submitted
  end

  def test_find_all_with_description_single_char
    skip
    description_fragment = "a"
    expected             = 1348
    submitted            = @ir.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_specific_word
    skip
    description_fragment = "Paypal"
    expected             = 7
    submitted            = @ir.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_partial_word
    skip
    description_fragment = "Pa"
    expected             = 572
    submitted            = @ir.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_special_char_present
    skip
    description_fragment = "ö"
    expected             = 19
    submitted            = @ir.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_foreign_char_returns_empty_array
    skip
    description_fragment = "繋"
    expected             = []
    submitted            = @ir.find_all_with_description(description_fragment)

    assert_equal expected, submitted
  end

  def test_find_all_by_price
    skip
    price     = 25.00
    expected  = 79
    submitted = @ir.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price
    skip
    price     = 10.00
    expected  = 63
    submitted = @ir.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price
    skip
    price     = 20000.00
    expected  = 0
    submitted = @ir.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price_empty_array
    skip
    price     = "0"
    expected  = []
    submitted = @ir.find_all_by_price(price)

    assert_equal expected, submitted
  end

  def test_find_all_by_price_correct_unit_price_but_with_symbol
    skip
    price     = $9500
    expected  = []
    submitted = @ir.find_all_by_price(price)

    assert_equal expected, submitted
  end

  def test_find_all_by_price_in_range_lowest
    skip
    range     = (0..1)
    expected  = 6
    submitted = @ir.find_all_by_price_in_range(range)

    assert_equal expected, submitted.length
  end

  def test_find_all_by_price_in_range_lower
    skip
    range     = (10..15)
    expected  = 205
    submitted = @ir.find_all_by_price_in_range(range)

    assert_equal expected, submitted.length
  end

  def test_find_all_by_price_in_range_upper
    skip
    range     = (1000..1500)
    expected  = 19
    submitted = @ir.find_all_by_price_in_range(range)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price_in_range_mid
    skip
    range     = (10..150)
    expected  = 910
    submitted = @ir.find_all_by_price_in_range(range)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_real_merchant
    skip
    merchant_id = 12334105
    expected    = 3
    submitted   = @ir.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_second_real_merchant
    skip
    merchant_id = 12334123
    expected    = 25
    submitted   = @ir.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_fake_merchant
    skip
    merchant_id = 1
    expected    = []
    submitted   = @ir.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted
  end
end
