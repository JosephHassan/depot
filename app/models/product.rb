class Product < ActiveRecord::Base
  # insure that the user has provided a title, description and an image URL
  validates :title, :description, :image_url, presence: true
  
  # insure that the user has provided a valid price for the product
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  
  # insure that there are no duplicate products with the same name
  validates :title, uniqueness: true
  
  # insure proper title length
  validates_length_of :title, minimum: 10, too_short: "Joseph Says Product title must contain at least 10 characters"
  
  # insure the user provide a valid image extension
  validates :image_url, allow_blank: true, format: { 
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'
        }
  
  def self.latest
    Product.order(:updated_at).last
  end
  
end
