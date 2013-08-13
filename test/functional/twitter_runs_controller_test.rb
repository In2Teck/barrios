require 'test_helper'

class TwitterRunsControllerTest < ActionController::TestCase
  setup do
    @twitter_run = twitter_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitter_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitter_run" do
    assert_difference('TwitterRun.count') do
      post :create, twitter_run: { accounted: @twitter_run.accounted, miles: @twitter_run.miles, pace: @twitter_run.pace, run_url: @twitter_run.run_url, user_id: @twitter_run.user_id }
    end

    assert_redirected_to twitter_run_path(assigns(:twitter_run))
  end

  test "should show twitter_run" do
    get :show, id: @twitter_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twitter_run
    assert_response :success
  end

  test "should update twitter_run" do
    put :update, id: @twitter_run, twitter_run: { accounted: @twitter_run.accounted, miles: @twitter_run.miles, pace: @twitter_run.pace, run_url: @twitter_run.run_url, user_id: @twitter_run.user_id }
    assert_redirected_to twitter_run_path(assigns(:twitter_run))
  end

  test "should destroy twitter_run" do
    assert_difference('TwitterRun.count', -1) do
      delete :destroy, id: @twitter_run
    end

    assert_redirected_to twitter_runs_path
  end
end
