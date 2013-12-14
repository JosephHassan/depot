class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @time = Time.now().to_formatted_s(:short)
  end
end
