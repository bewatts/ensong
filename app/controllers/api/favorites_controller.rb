class Api::FavoritesController < ApplicationController
  
  def create
    @favorite = current_user.favorites.new(:loop_collection_id => params[:loop_collection_id])
    if @favorite.save
      render :json => @favorite
    else
      render :json => {:msg => "problems saving favorite"}, :status => 422
    end
  end
  
  def destroy
    @favorite = Favorite.find_by_loop_collection_id_and_user_id( params[:loop_collection_id], current_user.id)
                
    if @favorite && @favorite.destroy
      render :json => {:msg => "Favorite Destroyed"}, :header => 200
    else
      render :json => @favorites.errors.full_messages, :header => 422
    end
  end
  
  def index
    @favorites = Favorite.where(:loop_collection_id => params[:loop_collection_id]);
    return :json => @favorites
  end
end
