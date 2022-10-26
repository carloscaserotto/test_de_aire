require "test_helper"

class TdasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tdas_index_url
    assert_response :success
  end

  test "should get new" do
    get tdas_new_url
    assert_response :success
  end

  test "should get show" do
    get tdas_show_url
    assert_response :success
  end

  test "should get edit" do
    get tdas_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get tdas_destroy_url
    assert_response :success
  end
end
