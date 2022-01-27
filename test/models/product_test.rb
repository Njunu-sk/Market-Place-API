require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test 'should have a positive price' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test 'should filter a products by name' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test 'should filter products by name and sort them' do
    assert_equal [products(:another_tv), products(:one)],
  Product.filter_by_title('tv').sort
  end

  test 'should filter products by price and sort them' do
    assert_equal [products(:two), products(:one)], Product.above_or_equal_to_price(200).sort
  end

  test 'should filter products by price lower and sort them' do
    assert_equal [products(:another_tv)], Product.below_or_equal_to_price(200).sort
  end

  test 'search should not find "videogame" and "100" as min price' do
    search_hash = { keyword: 'videogame', min_price: 100 }
    assert Product.search(search_hash).empty?
  end

  test 'should get all products when no parameters' do
    assert_equal Product.all.to_a, Product.search({})
  end

  test 'search should filter by product ids' do
    search_hash = { product_ids: [products(:one).id] }
    assert_equal [products(:one)], Product.search(search_hash)
  end
end
