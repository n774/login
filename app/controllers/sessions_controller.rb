class SessionsController < ApplicationController
  def index
    render 'login', :layout => true
  end
 
  def new 
    @user = User.new

    respond_to do |format|
      format.html 
      format.json { render json: @user }
    end
  end
  
  def create
    user = User.find_by_account params[:account]
    if user && user.authenticate(params[:pass])
      session[:user_id] = user.id

      @login = User.find_by_account params[:account]

	respond_to do |format|
	  format.html {render 'login_success'}
	  format.json {render :json => @login}
        end
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
