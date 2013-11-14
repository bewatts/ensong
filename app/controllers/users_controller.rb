class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      login_user(@user)
      flash[:success] = ["Welcome, #{@user.username}"]
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:favorited_loop_collections => :favorites, 
                          :loop_collections => :favorites).find(params[:id])
    @loop_collection = LoopCollection.new
    @user_collections = @user.loop_collections
    @favorite_collections = @user.favorited_loop_collections
    
    render :show
  end
  
  def demo
    @user = User.create_demo_account
    flash[:success] = ["Welcome to your demo account."]
    login_user(@user)        
    redirect_to user_url(@user)
  end
end
