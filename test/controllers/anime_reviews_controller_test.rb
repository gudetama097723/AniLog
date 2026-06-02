require "test_helper"

class AnimeReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get anime_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get anime_reviews_show_url
    assert_response :success
  end

  test "should get new" do
    get anime_reviews_new_url
    assert_response :success
  end

  test "should get edit" do
    get anime_reviews_edit_url
    assert_response :success
  end
end
