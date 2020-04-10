class ItemsController < ApplicationController
  
  # lets a user view all items if logged in
  # redirects to login page if not logged in
  get '/items' do
    if logged_in?
      erb :'items/items'
    else
      redirect_if_not_logged_in
    end
  end
  
  # lets user create a item if they are logged in
  get '/items/new' do
    if logged_in?
      erb :'/items/create_item'
    else
      redirect_if_not_logged_in
    end
  end
  
  # does not let a user create a blank item
  post '/items' do
    if params[:description].empty? || params[:amount].empty? || params[:list_name].empty?
      flash[:message] = "Please don't leave blank content."
      redirect to "/items/new"
    else
      @user = current_user
      @list = @user.lists.find_or_create_by(name:params[:list_name])
      @list.user_id = @user.id
      @item = Item.create(description:params[:description], amount:params[:amount], list_id:@list.id, user_id:@user.id)
      redirect to "/items/#{@item.id}"
    end
  end