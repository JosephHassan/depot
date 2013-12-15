class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  
  def total_price
    total = product.price * quantity
    return total
  end
end
