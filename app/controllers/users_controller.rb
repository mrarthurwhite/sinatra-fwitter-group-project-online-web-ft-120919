class UsersController < ApplicationController



  get "/signup" do
    #binding.pry
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :'/users/signup'
  end

  post "/signup" do
    username = params[:username]
    pwd = params[:password]
    email = params[:email]
    if !username.empty? && !pwd.empty? && !email.empty?
      @user = User.new(:username => username, :password => pwd, :email=>email)
    else
      redirect "/signup"
    end

    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end


  get "/users/:user_name" do
    user_name = params[:user_name]
    @user = User.find_by(:username => user_name)
    erb :'/users/mytweets'
  end


  get "/login" do
    if Helpers.is_logged_in?(session)
      redirect "/tweets"
    end
    erb :'/users/login'
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    #binding.pry
    if !!user && !!user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get "/failure" do
    erb :'/users/failure'
  end

  get "/logout" do
    if !Helpers.is_logged_in?(session)
      redirect "/"
    end
    session.clear
    redirect "/login"
  end


end
