require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    usr1 = users(:user_one)
    post :create, name: usr1.name, password: 'secret'
    assert_redirected_to admin_url
    assert_equal usr1.id, session[:user_id]
  end

  test "should fail login" do
    usr1 = users(:user_one)
    post :create, name: usr1.name, password: 'wrong_password'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_url
  end

end
