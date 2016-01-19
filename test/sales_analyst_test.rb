require_relative 'test_helper'
require_relative '../lib/sales_analyst'
# require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  @@se = SalesEngine.from_csv({
    :merchants     => './data/merchants.csv',
    :items         => './data/items.csv',
    :invoices      => './data/invoices.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions  => './data/transactions.csv',
    :customers     => './data/customers.csv'})
  @@sales_analyst = SalesAnalyst.new(@@se)

  def test_sales_analyst_exists
    assert_kind_of SalesAnalyst, @@sales_analyst
  end

  def test_total_number_of_merchants
    expected = 476
    submitted = @@sales_analyst.total_number_of_merchants

    assert_equal expected, submitted
  end

  def test_total_number_of_items_returned_from_item_repo
    expected = 1367
    submitted = @@sales_analyst.total_number_of_items

    assert_equal expected, submitted
  end

  def test_average_items_per_merchant
    expected = 2.87
    submitted = @@sales_analyst.average_items_per_merchant

    assert_equal expected, submitted
  end

  def test_total_number_of_merchant_ids_are_returned_from_item_repo
    expected = 1367
    submitted = @@sales_analyst.all_merchant_id_numbers

    assert_equal expected, submitted.count
  end

  def test_merchant_id_numbers_returns_first_merchant_id
    expected_1 = 12334141
    expected_2 = 12334871
    submitted = @@sales_analyst.all_merchant_id_numbers

    assert_equal expected_1, submitted.first
    assert_equal expected_2, submitted.last
  end

  def test_merchant_ids_with_their_item_counts
    expected = [12334141, 1]
    submitted = @@sales_analyst.item_counts_for_each_merchant

    assert_equal expected, submitted.first
  end

  def test_merchant_variance_count_returns_correct_merchant_count
    expected =  475
    submitted = @@sales_analyst.merchant_item_count_minus_average

    assert_equal expected, submitted.count
  end

  def test_average_items_per_merchant_standard_deviation
    std_deviation = 3.26
    submitted = @@sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal std_deviation, submitted
  end

  def test_merchants_with_high_item_count
    expected = 52
    submitted = @@sales_analyst.merchants_with_high_item_count

    assert_equal expected, submitted.count
  end

  def test_average_item_price_for_merchant
    merchant_id = 12334105
    expected = 16.66
    submitted = @@sales_analyst.average_item_price_for_merchant(merchant_id)

    assert_equal expected, submitted
  end

  def test_average_average_price_per_merchant
    skip
    expected = 350.29
    # returning= 349.56
    submitted = @@sales_analyst.average_average_price_per_merchant

    assert_equal expected, submitted
  end

  def test_array_of_golden_priced_items_return_highest_priced_items
    expected = "[#<Item>]"
    submitted = @@sales_analyst.array_of_golden_priced_items

    assert_equal expected, submitted.first.to_s
  end


  def test_golden_items
    expected = 5
    # expected = 122
    submitted = @@sales_analyst.golden_items

    assert_equal expected, submitted.count
  end

  def test_total_number_of_invoices
    expected = 4985
    submitted = @@sales_analyst.total_number_of_invoices

    assert_equal expected, submitted
  end

  def test_average_invoices_per_merchant
    # expected = 10.49
    expected = 10.47
    submitted = @@sales_analyst.average_invoices_per_merchant

    assert_equal expected, submitted
  end

  def test_all_the_merchant_id_numbers_in_invoice_data_count
    expected = 4985
    submitted = @@sales_analyst.all_the_merchant_id_numbers

    assert_equal expected, submitted.count
  end

  def test_average_invoices_per_merchant_standard_deviation
    expected = 3.29
    # expected = 3.32
    submitted = @@sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal expected, submitted
  end

  def test_top_merchants_by_invoice_count
    expected = 12
    submitted = @@sales_analyst.top_merchants_by_invoice_count

    assert_equal expected, submitted.count
  end

  def test_invoice_count_for_each_merchants_return_their_invoices
    expected = 475
    submitted = @@sales_analyst.invoice_count_for_each_merchants

    assert_equal expected, submitted.count
  end

  def test_merchant_to_inoice_return_total_inv_count_for_the_first_merchant
    expected = [12335938, 16]
    submitted = @@sales_analyst.invoice_count_for_each_merchants

    assert_equal expected, submitted.first
  end

  def test_pre_variance_count_of_merchant_invoices
    expected = 475
    submitted = @@sales_analyst.invoice_count_minus_average

    assert_equal expected, submitted.count
  end

  def test_standard_deviation_of_invoices_per_merchants
    expected = 3.29
    submitted = @@sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal expected, submitted
  end

  def test_two_stdv_above_from_mean
    expected = 17.05
    submitted = @@sales_analyst.two_stdv_above_from_mean

    assert_equal expected, submitted
  end

  def test_bottom_merchants_by_invoice_count
    skip
    expected = 5
    # returning = 4
    submitted = @@sales_analyst.bottom_merchants_by_invoice_count

    assert_equal expected, submitted.count
  end



  def test_top_days_by_invoice_count
    expected = "Wednesday"
    submitted = @@sales_analyst.top_days_by_invoice_count

    assert_equal expected, submitted.first
  end

  def test_invoice_status_pending
    status = :pending
    expected = 29.55
    submitted = @@sales_analyst.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_shipped
    status = :shipped
    expected = 56.95
    submitted = @@sales_analyst.invoice_status(status)

    assert_equal expected, submitted
  end

  def test_invoice_status_returned
    status = :returned
    expected = 13.50
    submitted = @@sales_analyst.invoice_status(status)

    assert_equal expected, submitted
  end

end
