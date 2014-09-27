require 'test_helper'

class CuratedToursControllerTest < ActionController::TestCase
  setup do
    @curated_tour = curated_tours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:curated_tours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create curated_tour" do
    assert_difference('CuratedTour.count') do
      post :create, curated_tour: {  }
    end

    assert_redirected_to curated_tour_path(assigns(:curated_tour))
  end

  test "should show curated_tour" do
    get :show, id: @curated_tour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @curated_tour
    assert_response :success
  end

  test "should update curated_tour" do
    patch :update, id: @curated_tour, curated_tour: {  }
    assert_redirected_to curated_tour_path(assigns(:curated_tour))
  end

  test "should destroy curated_tour" do
    assert_difference('CuratedTour.count', -1) do
      delete :destroy, id: @curated_tour
    end

    assert_redirected_to curated_tours_path
  end
end