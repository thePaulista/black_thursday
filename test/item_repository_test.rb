require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'pry'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test

  def setup
    csv_object_of_items = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @item_repository = ItemRepository.new(csv_object_of_items)
  end

  def test_can_create_a_repo_of_items
    total_items = 1367
    first_id    = 263395237
    last_id     = 263567474

    assert_equal total_items, @item_repository.all.count
    assert_equal first_id, @item_repository.all[0].id
    assert_equal last_id, @item_repository.all[-1].id
  end

  def test_all_items
    total_items = 1367

    assert_equal total_items, @item_repository.all.count
  end

  def test_find_by_name_exact_search
    item_name = "510+ RealPush Icon Set"
    expected  = item_name
    submitted = @item_repository.find_by_name(item_name)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_insensitve_search
    item_name = "510+ RealPush Icon Set"
    expected  = item_name
    submitted = @item_repository.find_by_name(item_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_incomplete_name
    item_name = "510+"
    expected  = item_name
    submitted = @item_repository.find_by_name(item_name.upcase)

    assert_nil submitted
  end

  def test_find_by_name_rejects_bad_name
    item_name = "BurgerKing"
    submitted = @item_repository.find_by_name(item_name)

    assert_nil submitted
  end

  def test_find_by_given_item_id
    item_id   = 263395237
    expected  = item_id
    submitted = @item_repository.find_by_id(item_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    item_id   = 1
    expected  = item_id
    submitted = @item_repository.find_by_id(item_id)

    assert_nil submitted
  end

  def test_find_all_with_description_single_char
    description_fragment = "a"
    expected             = 1348
    submitted            = @item_repository.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_specific_word
    description_fragment = "Paypal"
    expected             = 7
    submitted            = @item_repository.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_partial_word
    description_fragment = "Pa"
    expected             = 572
    submitted            = @item_repository.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_special_char_present
    description_fragment = "ö"
    expected             = 19
    submitted            = @item_repository.find_all_with_description(description_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_with_description_foreign_char_returns_empty_array
    description_fragment = "繋"
    expected             = []
    submitted            = @item_repository.find_all_with_description(description_fragment)

    assert_equal expected, submitted
  end

  def test_find_all_by_price
    price     = 25.00
    expected  = 79
    submitted = @item_repository.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price
    price     = 10.00
    expected  = 63
    submitted = @item_repository.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price
    price     = 20000.00
    expected  = 0
    submitted = @item_repository.find_all_by_price(price)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price_empty_array
    price     = "0"
    expected  = []
    submitted = @item_repository.find_all_by_price(price)

    assert_equal expected, submitted
  end

  def test_find_all_by_price_correct_unit_price_but_with_symbol
    price     = $9500
    expected  = []
    submitted = @item_repository.find_all_by_price(price)

    assert_equal expected, submitted
  end

  def test_find_all_by_price_in_range_lowest
    range     = (0..1)
    expected  = 6
    submitted = @item_repository.find_all_by_price_in_range(range)

    assert_equal expected, submitted.length
  end

  def test_find_all_by_price_in_range_lower
    range     = (10..15)
    expected  = 205
    submitted = @item_repository.find_all_by_price_in_range(range)

    assert_equal expected, submitted.length
  end

  def test_find_all_by_price_in_range_upper
    range     = (1000..1500)
    expected  = 19
    submitted = @item_repository.find_all_by_price_in_range(range)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_price_in_range_mid
    range     = (10..150)
    expected  = 910
    submitted = @item_repository.find_all_by_price_in_range(range)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_real_merchant
    merchant_id = 12334105
    expected    = 3
    submitted   = @item_repository.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_second_real_merchant
    merchant_id = 12334123
    expected    = 25
    submitted   = @item_repository.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_merchant_id_fake_merchant
    merchant_id = 1
    expected    = []
    submitted   = @item_repository.find_all_by_merchant_id(merchant_id)

    assert_equal expected, submitted
  end

end
