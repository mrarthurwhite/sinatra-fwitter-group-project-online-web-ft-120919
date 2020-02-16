class MissionController < ApplicationController


  # index displays all missions
  get '/missions' do
    #binding.pry
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @missions = Mission.all
      erb :'/missions/index'
    else
      redirect to "/login"
    end
  end

  # new displays create tweet form
  get '/missions/new' do
    if Helpers.is_logged_in?(session)
      erb :'/missions/new'
    else
      redirect to "/login"
    end
  end

  #create creates one tweet
  post "/missions" do
    #binding.pry
    @mission = Mission.create(:content=>params["content"])
    @user=Helpers.current_user(session)
    @mission.user=@user

    if @mission.save
    redirect to "/missions/#{@mission.id}"
    else
      redirect to "/missions/new"
    end

  end

  #show displays one tweet based on ID in the url
  get "/missions/:id" do
    if Helpers.is_logged_in?(session)
      @mission = Mission.find_by_id(params[:id])
      erb :'/missions/show'
    else
      redirect to "/login"
    end

  end

  # edit displays edit form based on ID in the url
  get "/missions/:id/edit" do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      t_id=params[:id]
      @mission = @user.missions.find_by_id(t_id)
      if(!!@mission)
        erb :"/missions/edit"
      end
    else
      redirect to "/login"
    end
  end

  #update modifies an existing tweet based on ID in the url
  patch "/missions/:id" do
    @mission = Mission.find_by_id(params[:id])
    #binding.pry
    updated = @mission.update(:content=>params["content"])
    if !updated
      redirect to "/missions/#{@mission.id}/edit"
    end
    redirect to "/missions/#{@mission.id}"
  end

  # delete
  delete "/missions/:id" do
    @user = Helpers.current_user(session)
    @mission = @user.missions.find_by_id(params[:id])
    if(!!@mission)
      @mission.destroy
    end
    redirect to "/missions"
  end

end
