
class Invoice
  attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @customer_id = args_hash[:customer_id].to_i
    @merchant_id = args_hash[:merchant_id].to_i
    @status      = args_hash[:status]
    @created_at  = Time.parse(args_hash[:created_at])
    @updated_at  = Time.parse(args_hash[:updated_at])
    # @created_at  = args_hash[:created_at]
    # @updated_at  = args_hash[:updated_at]
  end

end
