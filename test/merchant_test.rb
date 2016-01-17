require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 12335971, :name => "Turing School"})
    @sales_engine = SalesEngine.from_csv({:invoices => './data/invoices.csv',
                                          :items => './data/items.csv'
                                         })
  end

  def test_inputs_are_name_and_id
    assert_equal 12335971, @merchant.id
    assert_equal "Turing School", @merchant.name
  end

  def test_items
    merchant_id = @merchant.id
    submitted = @sales_engine.items.find_all_by_merchant_id(merchant_id).to_a

    assert_equal 1, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Items, submitted.first
  end

  def test_invoices
    merchant_id = @merchant.id
    submitted = @sales_engine.invoices.find_all_by_merchant_id(merchant_id).to_a

    assert_equal 14, submitted.count
    assert_kind_of Array, submitted
    assert_kind_of Invoice, submitted.first
  end
end
