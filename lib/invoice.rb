
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at,
              :updated_at, :merchant, :items, :transactions, :customer
  attr_accessor :total

  def inspect
    "#<#{self.class}>"
  end

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @customer_id = args_hash[:customer_id].to_i
    @merchant_id = args_hash[:merchant_id].to_i
    @status      = args_hash[:status].to_sym
    @created_at  = Time.parse(args_hash[:created_at])
    @updated_at  = Time.parse(args_hash[:updated_at])
  end

  def specific_merchant(merchant)
    @merchant = merchant
  end

  def specific_items(items)
    @items = items
  end

  def specific_transactions(transactions)
    @transactions = transactions
  end

  def specific_customer(customer)
    @customer = customer
  end

  def is_paid_in_full?
    @transactions.any? { |transaction| transaction.result == "success" }
  end

  def total
    @total
    # @total = total
  end

end
