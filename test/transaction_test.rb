require './test/test_helper'
require './lib/transaction'
require 'date'

class TransactionTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @transaction = Transaction.new({:id => 6,
                                    :invoice_id => 8,
                                    :credit_card_number => "4242424242424242",
                                    :credit_card_expiration_date => "0220",
                                    :result => "success",
                                    :created_at => @time,
                                    :updated_at => @time
                                   })
  end

  def test_transaction_initializes_with_id
    assert_equal 6, @transaction.id
  end

  def test_transaction_initializes_with_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_transaction_initializes_with_credit_card_number
    assert_equal 4242424242424242, @transaction.credit_card_number
  end

  def test_transaction_initializes_with_credit_card_expiration_date
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_transaction_initializes_with_result
    result  = "success"
    assert_equal result, @transaction.result
  end

  def test_transaction_initializes_with_created_at
    assert_equal Time.parse(@time), @transaction.created_at
  end

  def test_transaction_initializes_with_updated_at
    assert_equal Time.parse(@time), @transaction.updated_at
  end

  def test_specific_invoice
    @@sales_engine.transaction_invoice_connection
    transaction = @@sales_engine.transactions.find_by_id(1452)
    submitted = transaction.invoice

    assert_kind_of Invoice, submitted
    assert_equal 4746, submitted.id
  end
end
