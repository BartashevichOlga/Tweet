class TweetController < ApplicationController
  def index
    @tweet = Tweet.new
  end

  def post_tweet
    @tweet = Tweet.new
    tweet(params)
    redirect_to root_path
  end

  def upload(params)
    if params.keys.include?('picture')
      uploaded = params['tweet']['picture']
      File.open(File.join('public/tweet_picture', uploaded.original_filename), 'wb') do |file|
        file.write(uploaded.read)
      end
      Tweet.create(tweet: params['tweet']['tweet'], picture: uploaded.original_filename, user_id: current_user.id)
    else
      Tweet.create(tweet: params['tweet']['tweet'], user_id: current_user.id)
    end
  end

  def tweet(params)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_APP_ID']
      config.consumer_secret = ENV['TWITTER_APP_SECRET']
      config.access_token = current_user.credentials_token
      config.access_token_secret = current_user.credentials_secret
    end
    if params['tweet']['tweet'].blank?
      flash[:error] = 'Write text tweets'
    elsif params.keys.include?('picture')
      client.update_with_media(params['tweet']['tweet'], params['tweet']['picture'].tempfile)
      upload(params)
      flash[:success] = 'Successfully tweeted on your account'
    else
      client.update(params['tweet']['tweet'])
      upload(params)
      flash[:success] = 'Successfully tweeted on your account'
    end
  end
end
