require './test/test_helper'
require './lib/invoice'
require 'date'
require 'time'
# require 'bigdecimal'

class InvoiceTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => :pending,
      :created_at  => @time,
      :updated_at  => @time,
    })
  end

  def test_invoice_kind_of?

  end

  def test_invoice_initializes_with_id
    id = 6
    assert_equal id, @i.id
  end

  def test_invoice_initializes_with_customer_id
    customer_id = 7
    assert_equal customer_id, @i.customer_id
  end

  def test_invoice_initializes_with_merchant_id
    merchant_id = 8
    assert_equal merchant_id, @i.merchant_id
  end

  def test_invoice_initializes_with_status
    status  = :pending
    assert_equal status, @i.status
  end

  def test_item_initializes_with_created_at
    assert_equal Time.parse(@time), @i.created_at
  end

end
