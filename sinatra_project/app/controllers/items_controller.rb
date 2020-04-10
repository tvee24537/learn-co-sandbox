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