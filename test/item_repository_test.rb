require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    csv_object_of_items = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    @ir = ItemRepository.new(csv_object_of_items)
    #expected
    #expected buy weird
    #2nd kind of weird
    #totally wrong
  end

  def test_can_create_a_repo_of_items
    total_items = 1367
    first_id    = 263395237
    last_id     = 263567474

    assert_equal total_items, @ir.all.count
    assert_equal first_id, @ir.all[0].id
    assert_equal last_id, @ir.all[-1].id
  end

  def test_all_items
    total_items = 1367

    assert_equal total_items, @ir.all.count
  end

  def test_find_by_name_exact_search
    item_name = "510+ RealPush Icon Set"
    expected  = item_name
    submitted = @ir.find_by_name(item_name)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_insensitve_search
    item_name = "510+ RealPush Icon Set"
    expected  = item_name
    submitted = @ir.find_by_name(item_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_incomplete_name
    item_name = "510+"
    expected  = item_name
    submitted = @ir.find_by_name(item_name.upcase)

    assert_nil submitted
  end

  def test_find_by_name_rejects_bad_name
    item_name = "BurgerKing"
    submitted = @ir.find_by_name(item_name)

    assert_nil submitted
  end

  def test_find_by_given_item_id
    item_id   = 263395237
    expected  = item_id
    submitted = @ir.find_by_id(item_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    item_id   = 1
    expected  = item_id
    submitted = @ir.find_by_id(item_id)

    assert_nil submitted
  end


  # def test_find_all_by_name_given_case_insensitive_fragment
  #   name_fragment = "SHOP"
  #   expected      = 26
  #   submitted     = @ir.find_all_by_name(name_fragment)
  #
  #   assert_equal expected, submitted.count
  # end
  #
  # def test_find_all_by_name_with_special_char
  #   name_fragment = "!"
  #   expected      = []
  #   submitted     = @ir.find_all_by_name(name_fragment)
  #
  #   assert_equal expected, submitted
  # end
  #
  # def test_find_all_by_name_with_exact_match
  #   name_fragment = "Shopin1901"
  #   expected      = 1
  #   submitted     = @ir.find_all_by_name(name_fragment)
  #
  #   assert_equal expected, submitted.count
  # end

end