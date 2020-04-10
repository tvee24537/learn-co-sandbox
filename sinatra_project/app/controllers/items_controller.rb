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
  
  # displays a single item
  get '/items/:id' do
    if logged_in?
      @item = Item.find(params[:id])
      erb :'items/show_item'
    else
      redirect_if_not_logged_in
    end
  end
  
# lets a user view item edit form if they are logged in
  # does not let a user edit a item user did not create
  get '/items/:id/edit' do
    if logged_in?
      @item = Item.find(params[:id])
      @list = List.find(@item.list_id)
      if @item.user_id == current_user.id
        erb :'items/edit_item'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end
