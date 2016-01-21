require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_number_of_merchants
    @sales_engine.merchants.all.count
  end

  def total_number_of_items
    @sales_engine.items.all.count
  end

  def average_items_per_merchant
    average = total_number_of_items / total_number_of_merchants.to_f
    average.round(2)
  end #2.87 with new num of merchants

  def all_merchant_id_numbers
    all_items = @sales_engine.items.all
    all_items.map {|item| item.merchant_id}
  end

  def item_counts_for_each_merchant
    id_count_pairs = all_merchant_id_numbers
    id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }
  end

  def merchant_item_count_minus_average
    item_counts = item_counts_for_each_merchant.values
    avg = average_items_per_merchant
    item_counts.map {|item| (item - avg) ** 2}
  end #5034.9475

  def average_items_per_merchant_standard_deviation
   avg_subtracted_counts = merchant_item_count_minus_average
   variance = avg_subtracted_counts.inject(0,:+) / (avg_subtracted_counts.count - 1)
   stdv = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count_ids_only
    one_stdv_above_avg = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merch_count_pairs = item_counts_for_each_merchant.find_all do |merch_id, item_count|
      merch_id if item_count > (one_stdv_above_avg)
    end
    merch_count_pairs.map do |pair|
      pair[0]
    end
  end

  def merchants_with_high_item_count
    merchants = merchants_with_high_item_count_ids_only
    merchants.map do |id|
      @sales_engine.merchants.find_by_id(id)
    end
  end

  def merchants_with_all_their_items
    all_items = @sales_engine.items.all
    all_items.group_by do |item|
      item.merchant_id
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchants_items = merchants_with_all_their_items[merchant_id]
    all_unit_prices = merchants_items.map do |item|
      item.unit_price
    end
    (((all_unit_prices.reduce(:+) / all_unit_prices.count)) / 100).round(2)
  end

  def average_price_per_merchant
    all_items = @sales_engine.items.all
    all_items_merchant_ids = all_items.map do |item|
      item.merchant_id
    end
    (all_items_merchant_ids.uniq).map do |merch_id|
      average_item_price_for_merchant(merch_id)
    end
  end

  def average_average_price_per_merchant
    avg_all = average_price_per_merchant
    (avg_all.reduce(:+) / total_number_of_merchants).round(2)
  end

  def all_items_unit_prices
    all_items = @sales_engine.items.all
    all_items.map { |item| item.unit_price }
  end

  def calc_average_unit_price_all_items
    # returns BigDecimal of average unit price for all items
    all_prices = all_items_unit_prices
    (all_prices.reduce(:+) / total_number_of_items)
  end

  def items_unit_price_minus_average
    avg = calc_average_unit_price_all_items
    all_prices = all_items_unit_prices
    all_prices.map { |price| ((price - avg) ** 2) }
  end

  def items_unit_price_standard_deviation
    avg_subtracted_items = items_unit_price_minus_average
    variance = avg_subtracted_items.inject(0,:+) / (avg_subtracted_items.count - 1)
    stdv = Math.sqrt(variance).round(2)
  end

  def items_unit_price_above_two_standard_deviation
    calc_average_unit_price_all_items + (items_unit_price_standard_deviation * 2)
  end

  def prices_of_golden_items
    two_stdv = items_unit_price_above_two_standard_deviation
    all_unit_prices = @sales_engine.items.all
    all_items_unit_prices.find_all do |unit_price|
      unit_price > two_stdv
    end
  end

   def array_of_golden_priced_items
     prices_of_golden_items.map do |p|
        priced = @sales_engine.items.find_all_by_price(p)
     end
   end

   def golden_items
     array_of_golden_priced_items.collect {|g| g.first}
   end

  def invoice_status(status)
    status_count = @sales_engine.invoices.find_all_by_status(status).count
    all_invoices = @sales_engine.invoices.all.count
    raw_percentage = status_count / all_invoices.to_f
    (raw_percentage * 100).round(2)
  end

  def total_number_of_invoices
    @sales_engine.invoices.all.count  #count = 4985
  end

  def average_invoices_per_merchant  #required method
    avg = @sales_engine.invoices.all.count/total_number_of_merchants.to_f
    avg.round(2)
  end #answer = 10.49

#######find stdv
  def all_the_merchant_id_numbers
    # searches through Item Repo and returns array of all merchant_id strings
    all_invoices = @sales_engine.invoices.all
    all_invoices.map {|inv| inv.merchant_id}
  end

  def invoice_count_for_each_merchants #to get stdv for inv
    inv_count = all_the_merchant_id_numbers
    inv_count.inject(Hash.new(0)) { |hash, inv| hash[inv] += 1; hash }
  end

  def invoice_count_minus_average #to get stdv for inv
    merch_invoices = invoice_count_for_each_merchants.values
    avg = (@sales_engine.invoices.all.count / total_number_of_merchants)
    merch_invoices.map {|inv| (inv - avg) ** 2}
  end

  def average_invoices_per_merchant_standard_deviation #required method
    combo = invoice_count_minus_average
    diff_mean = combo.inject(0,:+) / (combo.count - 1)
    stdv_invoice = Math.sqrt(diff_mean)
    stdv_invoice.round(2) #answer = 3.29
    # binding.pry
  end
 ######finished std dev above for invoices

######question 2 - who are our top performing merchants?
  def two_stdv_above_from_mean #NEW
    avg = average_invoices_per_merchant
    stdv = average_invoices_per_merchant_standard_deviation
    avg + stdv + stdv
  end

  def merchant_id_for_two_stdv_above_mean #NEW
    invoices = invoice_count_for_each_merchants
    two_stdv = two_stdv_above_from_mean
    invoices.select {|key, value| value > two_stdv }.keys
  end #returns an array of 12 merchant_ids

  def top_merchants_by_invoice_count  #required method NEW
    merchants = merchant_id_for_two_stdv_above_mean
    merchants.map {|merchant_id| @sales_engine.merchants.find_by_id(merchant_id)}
  end

###above is question 2, below anwers question 3
  def two_stdv_below_from_mean
    avg = average_invoices_per_merchant
    stdv = average_invoices_per_merchant_standard_deviation
    avg - stdv - stdv
  end #returns 3.89

  def merchants_id_for_two_stdv_below_mean
    invoices = invoice_count_for_each_merchants
    two_stdv = two_stdv_below_from_mean
    invoices.select {|key, value| value < two_stdv}.keys
  end #returning four merchants for now, expected 5

  def bottom_merchants_by_invoice_count #required method
    merchants = merchants_id_for_two_stdv_below_mean
    merchants.map {|merchant_id| @sales_engine.merchants.find_by_id(merchant_id)}
  end #returns four merchant objects

  def collect_the_day_with_most_sales_among_top_sellers
      merchant_id = get_merchants_two_stdv_above_mean
  end

  def merchants_with_high_invoice_count
    merchant_ids = merchant_id_for_two_stdv_above_mean
    @sales_engine.invoices.all.select do |inv|
      merchant_ids.include?(inv.merchant_id)
    end #this returns 194 invoices belonging to top merchants
    # sort from highest sales to least
  end

  def find_all_sales_days_for_invoices_two_stdv_above_mean
    merchants_with_high_invoice_count.map do |inv|
      inv.created_at.strftime("%A")
      # binding.pry
    end
  end

  def get_hash_of_days_of_the_week_to_frequency
    top_days = find_all_sales_days_for_invoices_two_stdv_above_mean
    top_days.inject(Hash.new(0)) {|hash, days| hash[days] += 1; hash}
  end

  def top_days_by_invoice_count
    get_hash_of_days_of_the_week_to_frequency.sort_by {|k,v| v}.max.first(1)
  end

  def total_revenue_by_date(date)
    date_match_invoices = @sales_engine.invoices.find_all_by_created_at_date(date)

    qualified_payments = date_match_invoices.select do |invoice|
      invoice.is_paid_in_full? == true
    end

    invoice_item_match = qualified_payments.map do |invoice|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    invoice_item_match.flatten!

    prices = invoice_item_match.map do |inv_item|
      inv_item.unit_price * inv_item.quantity.to_i
    end

    final = prices.reduce(:+)
    BigDecimal.new(final) / 100
  end

###these two methods find merchants_with_pending_invoices

  def merchants_with_pending_invoices
    @sales_engine.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        !invoice.is_paid_in_full?
      end
    end
  end

  ##### the follow is for sa.merchants_with_only_one_item
  def merchants_ids_with_only_one_item
    item_counts_for_each_merchant.select {|k,v| v < 2}.keys
  end

  def merchants_with_only_one_item
    merchants_ids_with_only_one_item.map do |id|
      @sales_engine.merchants.find_by_id(id)
    end
  end

  def top_revenue_earners(count=20)
    merchants_ranked_by_revenue.take(count)
  end

  def merchants_ranked_by_revenue # 12334193
    merchants_sorted_by_revenue = @sales_engine.merchants.all.sort_by do |merchant|
      merchant.total_revenue
    end.reverse
    merchants_sorted_by_revenue.select do |merchant|
      merchant.total_revenue != 0
    end
  end

  def merchants_with_pending_invoices
    @sales_engine.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        !invoice.is_paid_in_full?
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_one_item = merchants_with_only_one_item
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    merchant.total_revenue
  end

  # def most_sold_item_for_merchant(merchant_id)
  #   # run through merchants
  #   # select the ones that have invoices that are paid in full
  #   #
  #   merchant_items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
  #   # binding.pry
  #   merchant_items.group_by do |item|
  #     inv_items = @sales_engine.invoice_items.find_all_by_item_id(item.id)
  #     inv_items.map do |inv_item|
  #       inv_item.quantity.to_i
  #     end.reduce(:+)
  #   end.max #.last
  # end

  def most_sold_item_for_merchant(merchant_id)
    invoices = @sales_engine.invoices.find_all_by_merchant_id(merchant_id)

    qualified_invoices = invoices.select do |invoice|
      invoice.is_paid_in_full?
    end

    qualified_inv_items = qualified_invoices.map do |invoice|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    # binding.pry
    qualified_inv_items.flatten!

    item_quantities = qualified_inv_items.map do |inv_item|
      item = @sales_engine.items.find
      {inv_item.item_id => inv_item.quantity.to_i}
    end

    item_quantities.max_by do |pairs|
      pairs.values
    end.keys

  end



# merchant_id = 12334189
#   expected = sales_analyst.most_sold_item_for_merchant(merchant_id)
#   expect(expected.map(&:id).include?(263524984)).to eq true
#
#   expect(expected.map(&:name).include?("Adult Princess Leia Hat")).to eq true
#   expect(expected.first.class).to eq Item

end

if __FILE__ == $0
se = SalesEngine.from_csv({
  :merchants     => './data/merchants.csv',
  :items         => './data/items.csv',
  :invoices      => './data/invoices.csv',
  :invoice_items => './data/invoice_items.csv',
  :transactions  => './data/transactions.csv',
  :customers     => './data/customers.csv'})

sa = SalesAnalyst.new(se)

date = Time.parse("2011-02-27")
# date = Time.parse("2012-03-27")
# date = Time.parse("2016-01-06")
# puts sa.total_revenue_by_date(date)
# puts sa.total_revenue_by_date(date).class

# sa.merchants_with_only_one_item
# sa.merchants_with_only_one_item_regsitered_in_month("March")
# =======
# sa.top_revenue_earners
# sa.merchants_ranked_by_revenue
# sa.revenue_by_merchant(12334194)
sa.most_sold_item_for_merchant(12334189)

end
