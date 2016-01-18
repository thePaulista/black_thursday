require 'bigdecimal'

class Item
  attr_reader :id, :name, :description, :unit_price, :updated_at,
              :created_at, :merchant_id, :merchant

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @name        = args_hash[:name]
    @description = args_hash[:description]

    if args_hash[:unit_price].is_a?(BigDecimal)
      @unit_price = args_hash[:unit_price]
    else
      @unit_price = BigDecimal.new(args_hash[:unit_price])
    end

    @created_at  = Time.parse(args_hash[:created_at])
    @updated_at  = Time.parse(args_hash[:updated_at])
    @merchant_id = args_hash[:merchant_id].to_i
  end

  def specific_merchant(merchant)
    @merchant = merchant
  end

end
