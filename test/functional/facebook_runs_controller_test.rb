require 'test_helper'

class FacebookRunsControllerTest < ActionController::TestCase
  setup do
    @facebook_run = facebook_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebook_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebook_run" do
    assert_difference('FacebookRun.count') do
      post :create, facebook_run: { accounted: @facebook_run.accounted, miles: @facebook_run.miles, pace: @facebook_run.pace, run_id: @facebook_run.run_id, user_id: @facebook_run.user_id }
    end

    assert_redirected_to facebook_run_path(assigns(:facebook_run))
  end

  test "should show facebook_run" do
    get :show, id: @facebook_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facebook_run
    assert_response :success
  end

  test "should update facebook_run" do
    put :update, id: @facebook_run, facebook_run: { accounted: @facebook_run.accounted, miles: @facebook_run.miles, pace: @facebook_run.pace, run_id: @facebook_run.run_id, user_id: @facebook_run.user_id }
    assert_redirected_to facebook_run_path(assigns(:facebook_run))
  end

  test "should destroy facebook_run" do
    assert_difference('FacebookRun.count', -1) do
      delete :destroy, id: @facebook_run
    end

    assert_redirected_to facebook_runs_path
  end
end
