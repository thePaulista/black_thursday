require 'pry'
require 'csv'
require 'set'
require_relative 'transaction'

class TransactionRepository

  def initialize(transactions)
    parse_transactions(transactions)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def parse_transactions(transactions)
    @transactions = transactions.map { |row| Transaction.new(row) }
  end

  def all
    @transactions
  end

  def find_by_id(inv_id)
    @transactions.find { |inv_item| inv_item.id == inv_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
    @transactions.find_all { |transaction| transaction.result == result }
  end

end

if __FILE__ == $0
# tr = TransactionRepository.new
# tr.from_csv("./data/transactions.csv")
# transaction = tr.find_by_id(6)
# puts transaction
end
