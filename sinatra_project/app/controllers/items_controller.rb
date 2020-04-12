class ItemsController < ApplicationController
  
  # lets user view all items if logged in
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
  
  # does not let user create a blank item
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
  
# lets user view item edit form if they are logged in
  # does not let user edit an item user did not create
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
  
  # does not let user edit an item with blank content
  patch '/items/:id' do
    if !params[:description].empty? && !params[:amount].empty?
      @item = Item.find(params[:id])
      @item.update(description:params[:description], amount:params[:amount])
      @list = current_user.lists.find_by(name:params[:list_name])
      @item.list_id = @list.id
      @item.save
      flash[:message] = "Your Item Has Been Succesfully Updated."
      redirect_to_home_page
    else
      flash[:message] = "Please Don't Leave Blank Content."
      redirect to "/items/#{params[:id]}/edit"
    end
  end
  
# lets user delete their own item if they are logged in
  # does not let user delete an item they did not create
  delete '/items/:id/delete' do
    if logged_in?
      @item = Item.find(params[:id])
      if @item.user_id == current_user.id
        @item.delete
        flash[:message] = "Your item has been deleted successfully."
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end

end