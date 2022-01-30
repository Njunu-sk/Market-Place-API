require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test 'should set total' do
    @order.placements = [
      Placement.new(product_id: @product1.id, quantity: 5),
      Placement.new(product_id: @product2.id, quantity: 5),
    ]
    @order.set_total!
    expected_total = @product1.price * 5 + @product2.price * 5

    assert_equal expected_total, @order.total
  end

  test 'build 2 placements for the order' do
    @order.build_placements_with_product_ids_and_quantities [
      { product_id: @product1.id, quantity: 5},
      { product_id: @product2.id, quantity: 5},
    ]

    assert_difference('Placement.count', 2) do
      @order.save
    end
  end

  test 'an order should command not too much product than available' do
    @order.placements << Placement.new(product_id: @product1.id, quantity: (1 + @product1.quantity))

    assert_not @order.valid?
  end
end
