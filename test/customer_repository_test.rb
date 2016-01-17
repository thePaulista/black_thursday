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
  end

  def test_find_by_customer_id_returns
    id = 2
    expected = id
    submitted = @cr.find_by_id(id)
    assert_equal expected, submitted.id
  end

  def test_find_by_all_first_names_returns_one_name
    first_name = "Cecilia"
    expected = first_name
    submitted = @cr.find_all_by_first_name(first_name)

    assert_equal expected, submitted.first.first_name
  end

  def test_find_by_all_last_names_returns_one_name
    last_name = "Osinski"
    expected = last_name
    submitted = @cr.find_all_by_last_name(last_name)

    assert_equal expected, submitted.first.last_name
  end

end
