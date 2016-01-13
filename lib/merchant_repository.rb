require 'pry'
require 'csv'
require 'set'
require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    parse_merchants(merchants)
  end

  def parse_merchants(merchants)
    @merchant_array = []
    merchants.each do |row|
      @id   = row[:id]
      @name = row[:name]
      # binding.pry
      # puts merchants = Hash[:id, @id, :name, @name]
      @merchant_array << Merchant.new(Hash[:id, @id], Hash[:name,@name] )
    end
  end

  def all
    @merchant_array
  end

  def find_by_name(merchant_name)
    if name_object = @merchant_array.find  {|n| n.name.downcase == merchant_name.downcase}
      name_object
    else
      puts "nil"
    end
  end

  def find_by_id(merchant_id)
    if id_object = @merchant_array.find {|i| i.id == merchant_id}
      id_object
    else
      puts "nil"
    end
  end

end

if __FILE__ == $0
# mr = MerchantRepository.new('./data/merchants.csv')
# mr.find_id(12334105)
# puts mr.parse_data(12334105)
end
