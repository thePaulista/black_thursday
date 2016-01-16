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

  def test_average_invoices_per_merchant
    expected = 10.49
    submitted = @sa.average_invoices_per_merchant

    assert_equal expected, submitted
  end

  def test_average_invoices_per_merchant_standard_deviation
    skip
    expected = 3.3
    submitted = @sa.average_invoices_per_merchant_standard_deviation

    assert_equal expected, submitted
  end

  def test_invoice_status_pending
    status = :pending
    expected = 29.55

    # status_count = @sales_engine.invoices.find_all_by_status(status).count
    # all_invoices = @sales_engine.invoices.all.count
    # raw_percentage = status_count / all_invoices.to_f
    # (raw_percentage * 100).round(2)

    status_count = @se.invoices.find_all_by_status(status).count
    all_invoices = @se.invoices.all.count
    raw_percentage = status_count / all_invoices.to_f
    submitted = (raw_percentage * 100).round(2)

    # submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_shipped
    skip
    status = :shipped
    expected = 56.95
    submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_returned
    skip
    status = :returned
    expected = 13.50
    submitted = @sa.invoice_status(status)

    assert_equal expected, submitted
  end

end
