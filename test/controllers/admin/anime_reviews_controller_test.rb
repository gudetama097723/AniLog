require "test_helper"

class Admin::AnimeReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_anime_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_anime_reviews_show_url
    assert_response :success
  end
end
