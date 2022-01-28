require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)

    @order_params = { order: { products_ids: [products(:one).id, products(:two).id], total: 50 } }
  end

  test 'should forbid orders for unlogged' do
    get api_v1_orders_url, as: :json
    assert_response :forbidden
  end

  test 'should show orders' do
    get api_v1_orders_url(@order),
      headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) }, as: :json
       assert_response :success

    json_response = JSON.parse(response.body, symbolize_names: true)
    # include_product_attr = json_response.dig(:included, 0, :attributes)
    # assert_equal @order.products.first.title, include_product_attr['title']

    assert_equal @order.products.first.title, json_response.dig(:included, 0, :attributes, :title)
    # assert_equal @product.user.id.to_s, json_response.dig(:data, :relationships, :user, :data, :id)
    # assert_equal @product.user.email, json_response.dig(:included, 0, :attributes, :email)
  end

  test 'should forbid create order for unlogged' do
    assert_no_difference('Order.count') do
      post api_v1_orders_url, params: @order_params, as: :json
    end
    assert_response :forbidden
  end

  test 'should create order with two products' do
    assert_difference('Order.count', 1) do
      post api_v1_orders_url, params: @order_params,
      headers: { Authorization: JsonWebToken.encode(user_id: @order.user_id) }, as: :json
    end
    assert_response :created
  end
end
