require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures(:products)
  # test "the truth" do
  #   assert true
  # end
  
  test "Product Attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
    
  end
  
  # test that the price is a valid one
  test "Product price is valid" do
    product = Product.new( title: "My test book title",
                            description: "Some test description goes here",
                            image_url: "image.jpg")
    
    # check for negative value   
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
  
    # check for zero value
    product.price = 0.001
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    # check for a valid value above 0
    product.price = 0.01
    assert product.valid?
    
  end
  
  # test that the image URL is valid
  def new_product(image_url)
    product = Product.new(title: "My test new title",
                          description: "My lovely test description",
                          price: 10.25,
                          image_url: image_url)
    return product
  end
  
  test "image url" do
    ok = ["image.jpg", "image.gif", "image.png"]
    bad = ["image.pdf", "word.doc", "excel.xls"]
    
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
      #print "#{name} appears to have passed"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should NOT be valid"
      #puts "tested invalid value #{name}"
    end
    
  end
  
  # test that the user can not add duplicate titles
  test "Duplicate title" do
    product = Product.new(title: products(:ruby).title,
                          description: "hello world",
                          image_url: "image.jpg",
                          price: 24)
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
  
end
