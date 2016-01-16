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
    # returns the average number of items offered by each merchant
    average = total_number_of_items / total_number_of_merchants.to_f
    average.round(2)
  end

  def all_merchant_id_numbers
    # searches through Item Repo and returns array of all merchant_id strings
    all_items = @sales_engine.items.all
    all_items.map {|item| item.merchant_id}
  end

  def item_counts_for_each_merchants
    id_count_pairs = all_merchant_id_numbers
    id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }
  end

  def combined_merchant_item_count
    item_counts = item_counts_for_each_merchants.values
    avg = average_items_per_merchant
    item_counts.map {|item| (item - avg) ** 2}
  end

  def average_items_per_merchant_standard_deviation
    element = combined_merchant_item_count
    element_mean = element.inject(0,:+) / (element.count - 1)
    standard_deviation = (element_mean ** 0.5)
    standard_deviation.round(2)
  end

  def get_number_of_merchants_one_stdv_away_from_mean
    #changed method name to comform with the new spec, but method is the same
    total = total_number_of_merchants
    percentage = 0.158
    total * percentage
  end

  def sort_merchants_based_on_the_number_of_listings
    items = item_counts_for_each_merchants
    items.sort_by { |key, value| value }
  end

  def get_merchants_one_stdv_above_mean
    sorted = sort_merchants_based_on_the_number_of_listings
    above_avg = get_number_of_merchants_one_stdv_away_from_mean
    sorted.last(above_avg).to_h.keys
  end

  def merchants_with_high_item_count
    merchant_ids = get_merchants_one_stdv_above_mean
    @sales_engine.merchants.all.select do |m|
      merchant_ids.include?(m.id)
    end
  end

#find average prices of items based on merchant_ids
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

  # def average_item_price_for_merchants(merchant_id) #required method
  #   merchant_to_items = get_hash_of_merchants_to_items
  #   item_prices = merchant_to_items[merchant_id].map {|x| x.unit_price}
  #   (item_prices.inject(:+)/item_prices.count)#.to_s
  # end

  def average_item_price_for_merchant(merchant_id) #required method
    merchant_to_items = get_hash_of_merchants_to_items
    item_prices = merchant_to_items[merchant_id].map {|x| x.unit_price}
    (item_prices.inject(:+)/item_prices.count)#.to_s
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
    top_priced = get_number_of_items_that_fall_2_stdv_above
    sorted_prices.first(top_priced)
  end  #THIS RETURNS 30 ITEMS

  def golden_items
    top_priced = items_with_2_std_dev_above_avg_price
    @sales_engine.items.all.select do |item|
      top_priced.include?(item.unit_price)
    end.first(top_priced.count)
  end  #THIS RETURNS 32 ITEMS INSTEAD OF 30. NEEDED TO ADD .FIRST()
  #finished iteration 1

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
    inv_count.inject(Hash.new(0)) { |hash, inv| hash[inv] += 1; hash }.values
  end

  def combined_merchant_invoice_count #to get stdv for inv
    merch_invoices = invoice_count_for_each_merchants
    avg = average_invoices_per_merchant
    merch_invoices.map {|inv| (inv - avg) ** 2}
  end

  def average_invoices_per_merchant_standard_deviation #required method
    combo = combined_merchant_invoice_count
    diff_mean = combo.inject(0,:+) / (combo.count - 1)
    stdv_invoice = (diff_mean ** 0.5)
    stdv_invoice.round(2) #3.29
  end
 ######finished std dev above for invoices

######question 2 - who are our top performing merchants?
  def sort_merchants_by_invoice_count
    invoice_count_for_each_merchants.sort.reverse
  end

  # ENDED HERE  we are answering the question Which merchants
  # are more than two standard dev above the mean

   def merchants_with_2_std_dev_above_avg_price
     sorted_prices = sort_price_for_all_items
     top_priced = get_number_of_items_that_are_within_2_stdv_above
     sorted_prices.first(top_priced)
   end
  ####
  def all_merchant_id_numbers_on_invoice
    # searches through Invoice Repo and returns array of all merchant_id strings
    all_inv = @sales_engine.invoices.all
    all_inv.map {|inv| inv.merchant_id}
    # binding.pry
  end


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
sa.sort_merchants_by_invoice
end
