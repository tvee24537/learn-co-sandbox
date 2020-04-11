require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

# Redirect to home page
  get '/' do
    if !logged_in?
      erb :index, :layout => :'not_logged_in_layout' #=> Log In Page
    else
      redirect_to_home_page
    end
  end


# methods of redirection
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login"
      end
    end

    def redirect_to_home_page
      redirect to "/items"
    end

    def redirect_to_categories
      redirect to "/lists"
    end

  end

end