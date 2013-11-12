class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    un = params[:user][:username]
    pw = params[:user][:password]
    @user = User.find_by_credentials(un, pw)
    if @user
      login_user
      flash[:success] = ["Welcome, #{un}"]
      redirect_to user_url(@user)
    else
      flash.now[:error] = ['Incorrect Credentials.  Try again?']
      @user = User.new
      render :new
    end
  end
  
  def destroy
    logout_user
    redirect_to root_url
  end 
end
