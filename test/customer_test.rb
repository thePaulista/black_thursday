require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @c = Customer.new({
      :id          => 6,
      :first_name  => "Joan",
      :last_name   => "Clarke",
      :created_at  => @time,
      :updated_at  => @time
      })
  end

  def test_customer_initializes_with_id

    assert_equal 6, @c.id
    refute_equal 7, @c.id
  end

  def test_customer_initializes_with_first_name

    assert_equal "Joan", @c.first_name
  end

  def test_customer_initializes_with_last_name

    assert_equal "Clarke", @c.last_name
    refute_equal "Joan", @c.last_name
  end

  def test_customer_initializes_with_created_at

    assert_equal Time.parse(@time), @c.created_at
  end

  def test_customer_initializes_with_updated_at

    assert_equal Time.parse(@time), @c.updated_at
  end

end
