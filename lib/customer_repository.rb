require 'pry'
require 'csv'
require_relative 'customer'

class CustomerRepository

  def initialize(customers)
    parse_customers(customers)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_customers(customers)
    @customers_array = customers.map { |row| Customer.new(row) }
  end

  def all
    @customers_array
  end

  def find_by_id(customer_id)
    @customers_array.find {|customer| customer.id == customer_id}
  end

  def find_all_by_first_name(first_name)
    @customer_array.find_all {|customer| customer.first_name == first_name}
  end

  def find_all_by_last_name(last_name)
    @customer_array.find_all {|customer| customer.last_name == last_name}
  end

end
