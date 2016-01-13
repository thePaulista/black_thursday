require 'pry'

class Merchant
  attr_accessor :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def name
  # binding.pry
    @name[:name]
  end

  def id
    @id[:id]
  end

end
