class TweetController < ApplicationController
  def index
    @tweet = Tweet.new
  end

  def post_tweet
    @tweet = Tweet.new
    client = gets_client
    tweet = params['tweet']['tweet']
    tweet(params, client, tweet)
    redirect_to root_path
  end

  def gets_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_APP_ID']
      config.consumer_secret = ENV['TWITTER_APP_SECRET']
      config.access_token = current_user.credentials_token
      config.access_token_secret = current_user.credentials_secret
    end
  end

  def tweet(params, client, tweet)
    if tweet.blank?
      flash[:error] = 'Write text tweets'
    elsif params['tweet'].keys.include?('picture')
      client.update_with_media(tweet, params['tweet'][:picture].tempfile)
      Tweet.create(tweet: tweet, picture: params['tweet']['picture'], user_id: current_user.id)
      flash[:success] = 'Successfully tweeted on your account'
    else
      client.update(tweet)
      Tweet.create(tweet: tweet, user_id: current_user.id)
      flash[:success] = 'Successfully tweeted on your account'
    end
  end
end
