require_relative 'test_helper'
require_relative '../lib/sales_analyst'
# require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                                :items => './data/items.csv'})
    @sa = SalesAnalyst.new(@se)
  end

  def test_sales_analyst_exists
    assert_kind_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    expected = 2.88
    submitted = @sa.average_items_per_merchant

    assert_equal expected, submitted
  end

  def test_calc_items_per_merchant_standard_deviation
    std_deviation = 3.26
    submitted = @sa.calc_items_per_merchant_standard_deviation

    assert_equal std_deviation, submitted
  end

  def test_merchants_with_high_item_count
    expected = 75
    submitted = @sa.merchants_with_high_item_count

    assert_equal expected, submitted.count
  end

  def test_average_item_price_for_merchant
    merchant_id = 12334194
    expected = "0.30285714285714285714E2"
    submitted = @sa.average_item_price_for_merchant(merchant_id)

    assert_equal expected, submitted.to_s
  end

  def test_average_average_price_per_merchant
    expected = "0.722510168421052631578947368419989473684210526316E3"
    submitted = @sa.average_average_price_per_merchant

    assert_equal expected, submitted.to_s
  end

  def test_golden_items
    expected = 30
    submitted = @sa.golden_items

    assert_equal expected, submitted.count
  end

end
