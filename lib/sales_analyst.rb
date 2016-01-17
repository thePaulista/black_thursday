require_relative 'sales_engine'
require 'bigdecimal'

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
  end

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
  end

  def average_items_per_merchant_stdv
   avg_subtracted_counts = merchant_item_count_minus_average
   mean = avg_subtracted_counts.inject(0,:+) / (avg_subtracted_counts.count - 1)
   stdv = Math.sqrt(mean).round(2)
  end

  def merchants_with_high_item_count
    avg_plus_stdv = average_items_per_merchant + average_items_per_merchant_stdv
    item_counts_for_each_merchant.find_all do |merch_id, item_count|
      merch_id if item_count > (avg_plus_stdv)
    end
  end

  ## DIVIDE ##

  def get_number_of_merchants_one_stdv_away_from_mean
    # changed method name to comform with the new spec, but method is the same
    total = total_number_of_merchants
    percentage = 0.158
    total * percentage
  end

  def sort_merchants_based_on_the_number_of_listings
    items = item_counts_for_each_merchant
    items.sort_by { |key, value| value }
  end

  def get_merchants_one_stdv_above_mean
    sorted = sort_merchants_based_on_the_number_of_listings
    above_avg = get_number_of_merchants_one_stdv_away_from_mean
    sorted.last(above_avg).to_h.keys
  end

#below starts the solution to find average prices of items based on merchant_ids
  def get_hash_of_merchants_to_items
    all_items = @sales_engine.items.all
    merchant_to_items = {}
    all_items.each do |item|
      id = item.merchant_id
      if !merchant_to_items.has_key?(id)
        merchant_to_items[id] = [item]
      else
        merchant_to_items[id] << item
      end
    end
    merchant_to_items
  end

  def average_item_price_for_merchant(merchant_id) #required method
    merchant_to_items = get_hash_of_merchants_to_items
    item_prices = merchant_to_items[merchant_id].map {|x| x.unit_price}
    # (item_prices.inject(:+)/item_prices.count)#.to_s
    (item_prices.inject(:+)/item_prices.count)
  end

  def average_price_per_merchant
    all_items = @sales_engine.items.all
    all_items.map {|item| item.unit_price}.inject(:+)/all_items.count
    #result need to be .to_s??
    # binding.pry
    end

  def average_average_price_per_merchant #required method new
    avg_all = average_price_per_merchant
    (avg_all * total_number_of_items)/ total_number_of_merchants #COME BACK TO THIS. USE REDUCE
  end

  def average_average_price_per_merchant #required method new
    avg_all = average_price_per_merchant
    (avg_all * total_number_of_items)/ total_number_of_merchants #COME BACK TO THIS. USE REDUCE
  end

  #finished relationship question 3 above, start question 4 below.
  def sort_price_for_all_items
    all_items = @sales_engine.items.all
    all_items.map {|item| item.unit_price}.sort.reverse
    #MAKE SURE THE SORT IS CORRECT
  end

  def get_number_of_items_that_are_within_2_stdv_above
    percentage_for_two_stdv_abv = 0.022
    (total_number_of_items * 0.022).round(0)  #=>30
  end

  def items_with_2_std_dev_above_avg_price
    sorted_prices = sort_price_for_all_items
    top_priced = get_number_of_items_that_are_within_2_stdv_above
    sorted_prices.first(top_priced)
  end  #THIS RETURNS 30 ITEMS

  def golden_items
    top_priced = items_with_2_std_dev_above_avg_price
    @sales_engine.items.all.select do |item|
      top_priced.include?(item.unit_price)
    end.first(top_priced.count)
  end  #THIS RETURNS 32 ITEMS INSTEAD OF 30. NEEDED TO ADD .FIRST()
  #finished iteration 1

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

  def combined_merchant_invoice_count #to get stdv for inv
    merch_invoices = invoice_count_for_each_merchants.values
    avg = average_invoices_per_merchant
    merch_invoices.map {|inv| (inv - avg) ** 2}
  end

  def average_invoices_per_merchant_standard_deviation #required method
    combo = combined_merchant_invoice_count
    diff_mean = combo.inject(0,:+) / (combo.count - 1)
    stdv_invoice = (diff_mean ** 0.5)
    stdv_invoice.round(2) #answer = 3.29
  end
 ######finished std dev above for invoices

######question 2 - who are our top performing merchants?
  def get_merchant_count_two_stdv_from_mean
    total = total_number_of_merchants
    percentage = 0.022
    total * percentage #answer = 10.45
  end

  def sort_merchants_based_on_the_number_of_invoices
    invoices = invoice_count_for_each_merchants
    invoices.sort_by {|key, value| value}
  end

  def get_merchants_two_stdv_above_mean
    sorted = sort_merchants_based_on_the_number_of_invoices
    above_avg = get_merchant_count_two_stdv_from_mean
    sorted.last(above_avg).to_h.keys
  end

####this method is essentially >invoice.merchant Answer to Q2

  def top_merchants_by_invoice_count  #required method
    merchants = get_merchants_two_stdv_above_mean
    merchants.map {|merchant_id| @sales_engine.merchants.find_by_id(merchant_id)}
  end

###above is question 2, below anwers question 3
  def get_merchants_two_stdv_below_mean
    sorted = sort_merchants_based_on_the_number_of_invoices
    below_avg = get_merchant_count_two_stdv_from_mean
    sorted.first(below_avg).to_h.keys
  end

  def bottom_merchants_by_invoice_count #required method
    merchants = get_merchants_two_stdv_below_mean
    merchants.map {|merchant_id| @sales_engine.merchants.find_by_id(merchant_id)}
  end

####################################
  #question 4, which days are more than 2 stdv above mean
 #  def sales_dates_from_invoice
 #    inv_days = @sales_engine.invoices.find_all_dates
 #    inv_days.inject(Hash.new(0)) {|hash,days| hash[days] += 1; hash}.sort_by.values
 # {"Tuesday"=>738, "Wednesday"=>724, "Sunday"=>691, "Monday"=>695, "Thursday"=>736, "Saturday"=>697, "Friday"=>704}
 #  end

#steps: 1.find merchant_id of the top performers GOT IT!
           #def get_merchants_two_stdv_above_mean
        # 2. find what days they sold items
        # 3. sort by highest date
        # 4. pick highest.
  def collect_the_day_with_most_sales_among_top_sellers
      merchant_id = get_merchants_two_stdv_above_mean
  end

  def merchants_with_high_invoice_count
    merchant_ids = get_merchants_two_stdv_above_mean
    @sales_engine.invoices.all.select do |inv|
      merchant_ids.include?(inv.merchant_id)
    end #this returns 194 invoices belonging to top merchants
    # sort from highest sales to least
  end

  def find_all_sales_days_for_invoices_two_stdv_above_mean
    merchants_with_high_invoice_count.map do |inv|
      inv.created_at.strftime("%A")
    end
  end

  def get_hash_of_days_of_the_week_to_frequency
    top_days = find_all_sales_days_for_invoices_two_stdv_above_mean
    top_days.inject(Hash.new(0)) {|hash, days| hash[days] += 1; hash}
  end #{"Friday"=>30, "Tuesday"=>32, "Sunday"=>32, "Saturday"=>23, "Wednesday"=>20, "Thursday"=>33, "Monday"=>24}

  def top_days_by_invoice_count
    get_hash_of_days_of_the_week_to_frequency.sort_by {|k,v| v}.last(1).flatten[0]
  end  #returns "Thursday", a string, and not array

end

if __FILE__ == $0
se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                           :items     => './data/items.csv',
                           :invoices  => './data/invoices.csv'})

sa = SalesAnalyst.new(se)
# sa.get_hash_of_merchants_to_items
# sa.average_item_price_for_merchants(12334275)
# sa.get_total_price_for_all_items
# sa.sort_price_for_all_items
# sa.get_number_of_items_that_fall_2_stdv_above
# puts sa.items_with_2_std_dev_above_avg_price.count
# puts sa.golden_items.count
# puts sa.get_merchants_one_stdv_above_mean
# sa.average_price_per_merchant
# sa.merchants_with_high_item_count
# sa.average_average_price_per_merchant
# sa.average_invoices_per_merchant
# sa.all_merchant_id_numbers
# sa.invoice_count_for_each_merchants
# sa.total_invoice_count_for_each_merchants
# sa.all_merchant_id_numbers_on_invoice
# sa.subtract_mean_from_each_value
# sa.average_invoices_per_merchant_standard_deviation
# sa.sort_merchants_by_invoice
# sa.get_number_of_merchants_two_stdv_above_mean
# sa.sort_merchants_based_on_the_number_of_invoices
# sa.get_merchants_one_stdv_above_mean
# sa.get_merchants_two_stdv_above_mean
# sa.top_merchants_by_invoice_count
# sa.bottom_merchants_by_invoice_count
# sa.top_merchants_by_invoice
# sa.get_merchants_two_stdv_below_mean
# sa.find_days_that_see_most_sales
# sa.get_hash_of_merchants_to_inv
# sa.merchants_with_high_invoice_count
# sa.sales_dates_from_invoice
# sa.find_all_dates
# sa.get_hash_of_days_of_the_week_to_frequency
# sa.top_days_by_invoice_count
end
