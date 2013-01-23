class SessionsController < ApplicationController
  def index
    render 'new', :layout => true
  end
  
  def create
    user = User.find_by_account params[:account]
    if user && user.authenticate(params[:pass])
      session[:user_id] = user.id

      @name = User.find_by_account params[:account]

	respond_to do |format|
	  format.html {render 'login_success'}
	  format.json {render :json => @name}
        end
    
      #render 'login_success', :layout => true, :json => @name
    else
      render 'login_failure', :layout => true
    end
  end

  def show
    user = User.find_by_account params[:account]
  end

  def destroy
    session[:user_id] = nil
    render "new", :layout => true
  end
end
