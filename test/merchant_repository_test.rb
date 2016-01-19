require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  csv_object_of_merchants = CSV.open './data/merchants.csv',
                            headers: true, header_converters: :symbol
  @@merchant_repo = MerchantRepository.new(csv_object_of_merchants)

  def test_can_create_a_repo_of_merchants
    total_merchants = 476
    first_id        = 12334105
    last_id         = 12337412

    assert_equal total_merchants, @@merchant_repo.all.count
    assert_equal first_id, @@merchant_repo.all[0].id
    assert_equal last_id, @@merchant_repo.all[-1].id
  end

  def test_all_merchants
    assert_equal 476, @@merchant_repo.all.count
  end

  def test_find_by_name_exact_search
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @@merchant_repo.find_by_name(merchant_name)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_insensitve_search
    merchant_name = "Shopin1901"
    expected      = merchant_name
    submitted     = @@merchant_repo.find_by_name(merchant_name.upcase)

    assert_equal expected, submitted.name
  end

  def test_find_by_name_case_incomplete_name
    merchant_name = "Shop"
    expected      = merchant_name
    submitted     = @@merchant_repo.find_by_name(merchant_name.upcase)

    assert_nil submitted
  end

  def test_find_by_name_rejects_bad_name
    merchant_name = "BurgerKing"
    submitted     = @@merchant_repo.find_by_name(merchant_name)

    assert_nil submitted
  end

  def test_find_by_given_merchant_id
    merchant_id = 12334132
    expected    = merchant_id
    submitted   = @@merchant_repo.find_by_id(merchant_id)

    assert_equal expected, submitted.id
  end

  def test_find_by_id_rejects_bad_id
    merchant_id = 1
    expected    = merchant_id
    submitted   = @@merchant_repo.find_by_id(merchant_id)

    assert_nil submitted
  end

  def test_find_all_by_name_given_single_character
    name_fragment = "S"
    expected      = 329
    submitted     = @@merchant_repo.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_name_given_case_insensitive_fragment
    name_fragment = "SHOP"
    expected      = 26
    submitted     = @@merchant_repo.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

  def test_find_all_by_name_with_special_char
    name_fragment = "!"
    expected      = []
    submitted     = @@merchant_repo.find_all_by_name(name_fragment)

    assert_equal expected, submitted
  end

  def test_find_all_by_name_with_exact_match
    name_fragment = "Shopin1901"
    expected      = 1
    submitted     = @@merchant_repo.find_all_by_name(name_fragment)

    assert_equal expected, submitted.count
  end

end
