require 'test_helper'

class RidesControllerTest < ActionController::TestCase
  setup do
    @ride = rides(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rides)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ride" do
    assert_difference('Ride.count') do
      post :create, :ride => { :depart_date => @ride.depart_date, :from => @ride.from, :preferences => @ride.preferences, :return_date => @ride.return_date, :to => @ride.to, :who => @ride.who }
    end

    assert_redirected_to ride_path(assigns(:ride))
  end

  test "should show ride" do
    get :show, :id => @ride
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ride
    assert_response :success
  end

  test "should update ride" do
    put :update, :id => @ride, :ride => { :depart_date => @ride.depart_date, :from => @ride.from, :preferences => @ride.preferences, :return_date => @ride.return_date, :to => @ride.to, :who => @ride.who }
    assert_redirected_to ride_path(assigns(:ride))
  end

  test "should destroy ride" do
    assert_difference('Ride.count', -1) do
      delete :destroy, :id => @ride
    end

    assert_redirected_to rides_path
  end
end
