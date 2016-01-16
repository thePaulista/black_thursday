require './test/test_helper'
require './lib/items'

class ItemTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @i = Items.new({
      :id          => 123456,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @time,
      :updated_at  => @time
    })
  end

  def test_item_initializes_with_id
    assert_equal 123456, @i.id
  end

  def test_item_initializes_with_name
    assert_equal "Pencil", @i.name
  end

  def test_item_initializes_with_description
    description = "You can use it to write things"
    assert_equal description, @i.description
  end

  def test_item_initializes_with_unit_price
    unit_price  = BigDecimal.new(10.99,4)
    assert_equal unit_price, @i.unit_price
  end

  def test_item_initializes_with_created_at
    assert_equal Time.parse(@time), @i.created_at
  end

  def test_item_initializes_with_updated_at
    assert_equal Time.parse(@time), @i.updated_at
  end

end
