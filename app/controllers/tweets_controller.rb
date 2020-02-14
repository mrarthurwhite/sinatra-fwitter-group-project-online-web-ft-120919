class TweetsController < ApplicationController


  # index displays all tweets
  get '/tweets' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to "/login"
    end
  end

  # new displays create tweet form
  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect to "/login"
    end
  end

  #create creates one tweet
  post "/tweets" do
    #binding.pry
    @tweet = Tweet.create(:content=>params["content"])
    @user=Helpers.current_user(session)
    @tweet.user=@user

    if @tweet.save
    redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/new"
    end

  end

  #show displays one tweet based on ID in the url
  get "/tweets/:id" do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to "/login"
    end

  end

  # edit displays edit form based on ID in the url
  get "/tweets/:id/edit" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      t_id=params[:id]
      @tweet = @user.tweets.find_by_id(t_id)
      if(!!@tweet)
        erb :"/tweets/edit"
      end
    else
      redirect to "/login"
    end
  end

  #update modifies an existing tweet based on ID in the url
  patch "/tweets/:id" do
    @tweet = Tweet.find_by_id(params[:id])
    #binding.pry
    updated = @tweet.update(:content=>params["content"])
    if !updated
      redirect to "/tweets/#{@tweet.id}/edit"
    end
    redirect to "/tweets/#{@tweet.id}"
  end

  # delete
  delete "/tweets/:id" do
    @user = Helpers.current_user(session)
    @tweet = @user.tweets.find_by_id(params[:id])
    if(!!@tweet)
      @tweet.destroy
    end
    redirect to "/tweets"
  end

end
