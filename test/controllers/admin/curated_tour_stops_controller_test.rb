require 'test_helper'

class Admin::CuratedTourStopsControllerTest < ActionController::TestCase
  setup do
    @curated_tour_stop = curated_tour_stops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:curated_tour_stops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create curated_tour_stop" do
    assert_difference('CuratedTourStop.count') do
      post :create, curated_tour_stop: { caption_text: @curated_tour_stop.caption_text, curated_tour_id: @curated_tour_stop.curated_tour_id, sequential_id: @curated_tour_stop.sequential_id, work_id: @curated_tour_stop.work_id }
    end

    assert_redirected_to admin_curated_tour_stop_path(assigns(:curated_tour_stop))
  end

  test "should show curated_tour_stop" do
    get :show, id: @curated_tour_stop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @curated_tour_stop
    assert_response :success
  end

  test "should update curated_tour_stop" do
    patch :update, id: @curated_tour_stop, curated_tour_stop: { caption_text: @curated_tour_stop.caption_text, curated_tour_id: @curated_tour_stop.curated_tour_id, sequential_id: @curated_tour_stop.sequential_id, work_id: @curated_tour_stop.work_id }
    assert_redirected_to admin_curated_tour_stop_path(assigns(:curated_tour_stop))
  end

  test "should destroy curated_tour_stop" do
    assert_difference('CuratedTourStop.count', -1) do
      delete :destroy, id: @curated_tour_stop
    end

    assert_redirected_to admin_curated_tour_stops_path
  end
end
