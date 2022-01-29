class EnoughProductsValidators < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        record.errors[product.title.to_s] << "Is it out of stock, just #{product.quantity} left"
      end
    end
  end
end