require 'test_helper'

class WorkdaysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Workday.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Workday.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Workday.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to workday_url(assigns(:workday))
  end

  def test_edit
    get :edit, :id => Workday.first
    assert_template 'edit'
  end

  def test_update_invalid
    Workday.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Workday.first
    assert_template 'edit'
  end

  def test_update_valid
    Workday.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Workday.first
    assert_redirected_to workday_url(assigns(:workday))
  end

  def test_destroy
    workday = Workday.first
    delete :destroy, :id => workday
    assert_redirected_to workdays_url
    assert !Workday.exists?(workday.id)
  end
end
