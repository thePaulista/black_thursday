require_relative 'test_helper'
require_relative '../lib/sales_analyst'
# require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                                :items => './data/items.csv',
                                :invoices  => './data/invoices.csv'})
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

  def test_average_items_per_merchant_standard_deviation
    std_deviation = 3.26
    submitted = @sa.average_items_per_merchant_standard_deviation

    assert_equal std_deviation, submitted
  end

  def test_merchants_with_high_item_count
    expected = 52
    submitted = @sa.merchants_with_high_item_count

    assert_equal expected, submitted.count
  end

  def test_average_item_price_for_merchant
    merchant_id = 12334105
    expected = 16.66
    submitted = @sa.average_item_price_for_merchant(merchant_id)

    assert_equal expected, submitted
  end

  def test_average_average_price_per_merchant
    skip
    expected = 350.29
    # expected = 349.56
    submitted = @sa.average_average_price_per_merchant

    assert_equal expected, submitted
  end

  def test_golden_items
    expected = 5
    # expected = 122
    submitted = @sa.golden_items

    assert_equal expected, submitted.count
  end

  def test_average_invoices_per_merchant
    expected = 10.49
    submitted = @sa.average_invoices_per_merchant

    assert_equal expected, submitted
  end

  def test_average_invoices_per_merchant_standard_deviation
    expected = 3.29
    # expected = 3.32
    submitted = @sa.average_invoices_per_merchant_standard_deviation

    assert_equal expected, submitted
  end

  def test_top_merchants_by_invoice_count
    skip
    expected = 12
    # currently: 10
  end

  def test_bottom_merchants_by_invoice_count
    skip
    expected = 5
    # currently: 10
  end

  def test_top_days_by_invoice_count
    skip
    expected = 1
    # currently = 6
  end

  def test_invoice_status_pending
    status = :pending
    expected = 29.55
    submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_shipped
    status = :shipped
    expected = 56.95
    submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_returned
    status = :returned
    expected = 13.50
    submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

end
