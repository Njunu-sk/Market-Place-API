require "test_helper"

class PlacementTest < ActiveSupport::TestCase
  setup do
    @placement = placements(:one)

    test 'descreases the product quantity by the placement quantity' do
      product = @placement.product

      assert_difference('product_quantity', -@placement.quantity) do
        @placement.decremenet_product_quantity
      end
    end
  end
end
