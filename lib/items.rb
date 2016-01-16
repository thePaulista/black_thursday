require 'bigdecimal'

class Items
  attr_accessor :id, :name, :description, :unit_price, :updated_at, :created_at, :merchant_id

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @name        = args_hash[:name]
    @description = args_hash[:description]

    if args_hash[:unit_price].is_a?(BigDecimal)
      @unit_price = args_hash[:unit_price]
    else
      @unit_price = BigDecimal.new(args_hash[:unit_price].insert(-3, "."),4)
    end

    @created_at  = Time.parse(args_hash[:created_at])
    @updated_at  = Time.parse(args_hash[:updated_at])
    @merchant_id = args_hash[:merchant_id].to_i
  end

end
