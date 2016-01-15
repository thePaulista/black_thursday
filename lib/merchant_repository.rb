require 'pry'
require 'csv'
require 'set'
require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    parse_merchants(merchants)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_merchants(merchants)
    @merchant_array = []
    merchants.each do |row|
      @merchant_array << Merchant.new(row)
    end
  end

  def all
    @merchant_array
  end

  def find_all_by_name(fragment)
    fragment = fragment.downcase
    @merchant_array.find_all do |merchant|
      merchant.name.downcase.include?(fragment)
    end
  end

  def find_by_name(merchant_name)
    @merchant_array.find { |n| n.name.downcase == merchant_name.downcase}
  end


  def find_by_id(merchant_id)
    @merchant_array.find { |i| i.id == merchant_id}
  end

end

if __FILE__ == $0

end
