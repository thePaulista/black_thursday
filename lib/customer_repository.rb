require 'pry'
require 'csv'
require_relative 'customer'

class CustomerRepository

  def initialize
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def from_csv(file)
    csv_file = CSV.open file, headers: true, header_converters: :symbol
    pre_parse = csv_file.map { |row| row.to_h }
    parse_customers(pre_parse)
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

  def find_all_by_first_name(fragment)
    fragment = fragment.downcase
    @customers_array.find_all do |customer|
      customer.first_name.downcase.include?(fragment)
    end
  end

  def find_all_by_last_name(fragment)
    fragment = fragment.downcase
    @customers_array.find_all do |customer|
      customer.last_name.downcase.include?(fragment)
    end
  end

end
