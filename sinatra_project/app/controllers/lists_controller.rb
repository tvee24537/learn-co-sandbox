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
  # does not let a user edit a list not created by it self
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

  # does not let a user edit a list with blank content
  patch '/lists/:id' do
    if !params[:name].empty?
      @list = List.find(params[:id])
      @list.update(name:params[:name])
      flash[:message] = "Your list has been updated successfully"
      redirect_to_lists
    else
      flash[:message] = "Please don't leave blank content"
      redirect to "/lists/#{params[:id]}/edit"
    end
  end

# lets a user delete their own list if they are logged in
  # does not let a user delete a list that user did not create
  delete '/lists/:id/delete' do
    if logged_in?
      if current_user.lists.size == 1
        flash[:message] = "You need at least one list to delete."
        redirect_to_categories
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

end 