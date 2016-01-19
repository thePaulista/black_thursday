class Customer
  attr_accessor :id, :first_name, :last_name, :created_at, :updated_at

  def inspect
    "#<#{self.class}>"
  end

  def initialize(args_hash)
    @id           = args_hash[:id].to_i
    @first_name   = args_hash[:first_name]
    @last_name    = args_hash[:last_name]
    @created_at   = Time.parse(args_hash[:created_at])
    @updated_at   = Time.parse(args_hash[:updated_at])
  end

end
