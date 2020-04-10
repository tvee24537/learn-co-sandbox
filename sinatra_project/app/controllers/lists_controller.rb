class ListsController < ApplicationController

  # lets user view expense lists if logged in
  get '/lists' do
    if logged_in?
      @lists = current_user.lists.all
      erb :'lists/lists'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let a user create a blank category
  post '/lists' do
    if params[:name].empty?
      flash[:message] = "Please Enter a List Name"
      redirect_to_lists
    else
      @user = current_user
      @list = List.create(name:params[:name], user_id:@user.id)
      redirect_to_lists
    end
  end

  # displays a single list
  