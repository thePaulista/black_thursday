require_relative 'test_helper'
require_relative '../lib/transaction_repo'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transaction_repo = TransactionRepository.new
    @transaction_repo.from_csv("./data/transactions.csv")
  end

  def test_can_create_a_repo_of_transactions
    total_items = 4985
    first_id    = 1
    last_id     = 4985

    assert_equal total_items, @transaction_repo.all.count
    assert_equal first_id, @transaction_repo.all[0].id
    assert_equal last_id, @transaction_repo.all[-1].id
  end

  def test_all_transactions
    assert_equal 4985, @transaction_repo.all.count
  end

  def test_find_by_id
    expected = 1
    submitted = @transaction_repo.find_by_id(expected)

    assert_equal expected, submitted.id
    assert_equal 4068631943231473, submitted.credit_card_number
    assert_equal "0217", submitted.credit_card_expiration_date
    assert_kind_of Transaction, submitted
  end

  def test_find_by_id_returns_nil
    expected = nil
    submitted = @transaction_repo.find_by_id(0)

    assert_equal expected, submitted
  end

  def test_find_all_by_invoice_id
    expected = 1
    invoice_id = 2179
    submitted = @transaction_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted.count
    assert_kind_of Transaction, submitted.first
  end

  def test_find_all_by_invoice_id_empty_array
    expected = []
    invoice_id = 14560
    submitted = @transaction_repo.find_all_by_invoice_id(invoice_id)

    assert_equal expected, submitted
    assert submitted.empty?
  end

  def test_find_all_by_credit_card_number
    card_number = 4848466917766329
    expected = 1
    submitted = @transaction_repo.find_all_by_credit_card_number(card_number)

    assert_equal expected, submitted.length
    assert_kind_of Transaction, submitted.first
  end

  def test_find_all_by_credit_card_number_empty_array
    expected = []
    card_number = 4848466917766328
    submitted = @transaction_repo.find_all_by_credit_card_number(card_number)

    assert_equal expected, submitted
    assert_equal 0, submitted.length
    assert_equal true, submitted.empty?
  end

  def test_find_all_by_result_success
    result = "success"
    submitted = @transaction_repo.find_all_by_result(result)

    assert_equal 4158, submitted.count
    assert_kind_of Transaction, submitted.first
    assert_equal result, submitted.first.result
  end

  def test_find_all_by_result_failed
    result = "failed"
    submitted = @transaction_repo.find_all_by_result(result)

    assert_equal 827, submitted.count
    assert_kind_of Transaction, submitted.first
    assert_equal result, submitted.first.result
  end
  
end
