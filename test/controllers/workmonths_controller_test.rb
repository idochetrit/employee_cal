require 'test_helper'

class WorkmonthsControllerTest < ActionController::TestCase
  setup do
    @workmonth = workmonths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workmonths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workmonth" do
    assert_difference('Workmonth.count') do
      post :create, workmonth: {  }
    end

    assert_redirected_to workmonth_path(assigns(:workmonth))
  end

  test "should show workmonth" do
    get :show, id: @workmonth
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workmonth
    assert_response :success
  end

  test "should update workmonth" do
    patch :update, id: @workmonth, workmonth: {  }
    assert_redirected_to workmonth_path(assigns(:workmonth))
  end

  test "should destroy workmonth" do
    assert_difference('Workmonth.count', -1) do
      delete :destroy, id: @workmonth
    end

    assert_redirected_to workmonths_path
  end
end
