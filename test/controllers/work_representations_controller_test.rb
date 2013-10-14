require 'test_helper'

class WorkRepresentationsControllerTest < ActionController::TestCase
  setup do
    @work_representation = work_representations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_representations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_representation" do
    assert_difference('WorkRepresentation.count') do
      post :create, work_representation: { Work_id: @work_representation.Work_id, fileext: @work_representation.fileext, url: @work_representation.url }
    end

    assert_redirected_to work_representation_path(assigns(:work_representation))
  end

  test "should show work_representation" do
    get :show, id: @work_representation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_representation
    assert_response :success
  end

  test "should update work_representation" do
    patch :update, id: @work_representation, work_representation: { Work_id: @work_representation.Work_id, fileext: @work_representation.fileext, url: @work_representation.url }
    assert_redirected_to work_representation_path(assigns(:work_representation))
  end

  test "should destroy work_representation" do
    assert_difference('WorkRepresentation.count', -1) do
      delete :destroy, id: @work_representation
    end

    assert_redirected_to work_representations_path
  end
end
