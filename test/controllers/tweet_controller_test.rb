require 'test_helper'

class TweetControllerTest < ActionDispatch::IntegrationTest
  test "should get tweet" do
    get tweet_tweet_url
    assert_response :success
  end

end
