class UsersController < ApplicationController
  
  before_filter :ensure_same_user, :only => :show
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      login_user
      flash[:success] = ["Welcome, #{@user.username}"]
      redirect_to user_url(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:loop_collections => :favorites).find(params[:id])
    @loop_collection = LoopCollection.new
    @user_collections = @user.loop_collections
    @favorite_collections = @user.favorited_loop_collections
    
    render :show
  end
  
  def demo
    @user = User.create_demo_account
    login_user        
    redirect_to user_url(@user)
  end
  
end
