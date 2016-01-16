class InvoiceItem
  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @item_id = args_hash[:item_id].to_i
    @invoice_id = args_hash[:invoice_id].to_i
    @quantity      = args_hash[:quantity]

    if args_hash[:unit_price].is_a?(BigDecimal)
      @unit_price = args_hash[:unit_price]
    else
      @unit_price  = BigDecimal.new(args_hash[:unit_price].insert(-3, "."),4)
    end

    @created_at  = Time.parse(args_hash[:created_at])
    @updated_at  = Time.parse(args_hash[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
