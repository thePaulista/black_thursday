require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @cr = CustomerRepository.new
    @cr.from_csv('./data/customers.csv')
  end

  def test_can_create_a_repo_of_customer_attributes
    total_count = 1000
    first_name = "Joey"
    last_name = "Ondricka"

    assert_equal total_count, @cr.all.count
    assert_equal first_name, @cr.all[0].first_name
    assert_equal last_name, @cr.all[0].last_name
  end

  def test_all_method_gives_correct_count

    assert_equal 1000, @cr.all.count
    refute_equal 0, @cr.all.count
  end

  def test_find_by_id_returns_id
    id = 2
    expected = id
    submitted = @cr.find_by_id(id)

    assert_equal expected, submitted.id
  end

  def test_find_by_customer_id_returns_nil
    id = 1000000
    expected = id
    submitted = @cr.find_by_id(id)

    assert_nil submitted
  end

  def test_find_by_all_first_names_returns_empty_when_not_found
    first_name = "Bird"
    expected = first_name
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal [], submitted
  end

  def test_find_by_all_first_name_given_single_character
    first_name = "S"
    expected = 221
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_first_name_given_three_character
    first_name = "Sam"
    expected = 4
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_first_name_given_case_insensitive_fragment
    first_name = "joEY"
    expected = 1
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_first_name_given_case_insensitive_fragment
    first_name = "Cecilia"
    expected = 1
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_last_name_returns_empty_array_with_bad_name
    last_name = "123"
    expected = []
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted
  end

  def test_find_by_all_last_name_given_a_single_fragment
    last_name = "z"
    expected = 61
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_last_name_given_three_fragments
    last_name = "Oni"
    expected = 2
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_last_name_given_case_insentive_name
    last_name = "ConSiDiNe"
    expected = 2
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted.count
  end

  def test_find_by_all_last_names_returns_one_name
    last_name = "Osinski"
    expected = last_name
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted.last_name
  end

end
