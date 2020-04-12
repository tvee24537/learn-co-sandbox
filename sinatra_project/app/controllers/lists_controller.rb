class ListsController < ApplicationController

  # lets user view item lists if logged in
  get '/lists' do
    if logged_in?
      @lists = current_user.lists.all
      erb :'lists/lists'
    else
      redirect_if_not_logged_in
    end
  end

  # does not let user create a blank list
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

  # displays a single list based on id
  get '/lists/:id' do
    if logged_in?
      @list = List.find(params[:id])
      erb :'lists/show_list'
    else
      redirect_if_not_logged_in
    end
  end

# lets a user view list edit form if they are logged in
  # does not let user edit a list not created by the user
  get '/lists/:id/edit' do
    if logged_in?
      @list = List.find(params[:id])
      if @list.user_id == current_user.id
        erb :'lists/edit_list'
      else
        redirect_to_lists
      end
    else
      redirect_if_not_logged_in
    end
  end

  # does not let user edit a list with blank content
  patch '/lists/:id' do
    if !params[:name].empty?
      @list = List.find(params[:id])
      @list.update(name:params[:name])
      flash[:message] = "Your list has been updated successfully."
      redirect_to_lists
    else
      flash[:message] = "Please don't leave blank content."
      redirect to "/lists/#{params[:id]}/edit"
    end
  end

# lets user delete their own list if they are logged in
  # does not let user delete a list that user did not create
  delete '/lists/:id/delete' do
    if logged_in?
      if current_user.lists.size == 1
        flash[:message] = "You need at least one list to delete."
        redirect_to_lists
      else
        @list = List.find(params[:id])
        if @list.user_id == current_user.id
          @list.destroy
          flash[:message] = "Your list has been deleted successfully."
          redirect_to_lists
        end
      end
    else
      redirect_if_not_logged_in
    end
  end
  
  # helper route created to edit items
  # file adds '/lists' to the edit link
  get '/lists/items/:id/edit' do
    if logged_in?
      @item = Item.find(params[:id])
      @list = List.find(@item.list_id)
      if @item.user_id == session[:user_id]
        erb :'items/edit_item'
      else
        redirect_to_home_page
      end
    else
      redirect_if_not_logged_in
    end
  end
  
end 