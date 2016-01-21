require 'pry'
require 'csv'
require 'set'
require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    @repo = {}
    parse_merchants(merchants)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_merchants(merchants)
    # @repo = merchants.map { |row| Merchant.new(row) }
    @repo = merchants.each_with_object({}) do |row, hash|
      hash[row[:id]] = Merchant.new(row)
    end
  end

  def all
    @all ||= @repo.map do |id, merchant|
      merchant
    end
    #@repo.map(&:last)
  end

  def find_all_by_name(fragment)
    fragment = fragment.downcase
    pair = @repo.find_all do |id, merchant|
      merchant.name.downcase.include?(fragment)
    end
    result = []
    if pair.count > 1
      adjusted = pair.map do |pair|
        pair[1]
      end
      result = adjusted
    elsif pair.count == 1
      result = pair[1]
    end
    result
  end

  def find_by_name(merchant_name)
    pair = @repo.find do |id, merchant|
      merchant.name.downcase == merchant_name.downcase
    end
    if pair == nil
      return nil
    else
      pair[1]
    end
  end

  def find_by_id(merchant_id)
    @repo[merchant_id.to_s]
  end


end

if __FILE__ == $0

end
