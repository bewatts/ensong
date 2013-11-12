class LoopCollectionsController < ApplicationController
  
  def new
    @loop_collection = LoopCollection.new
    render :new
  end

  def index
    @by_date = LoopCollection.includes(:favorites).order("created_at DESC")
    @by_favorites = LoopCollection.
                    includes(:favorites).
                    select("loop_collections.*, COUNT(favorites.id) AS favorites_count").
                    joins("LEFT OUTER JOIN favorites ON loop_collections.id = favorites.loop_collection_id").
                    group('loop_collections.id').
                    order("favorites_count DESC")
    render :index
  end
  
  def create 
    params["loops"].delete_if {|key, value| value["audio"] == nil} #deletes blank entries
    @collection
    begin
      ActiveRecord::Base.transaction do
        @loops = current_user.authored_loops.new(params[:loops].values)
        @collection = current_user.loop_collections.new(params[:loop_collection])
        @collection.loops = @loops
        @collection.save! 
        current_user.save!
      end
    rescue ActiveRecord::RecordInvalid
        flash[:error] = [@collection.errors.full_messages]
        redirect_to :back
    else
      redirect_to user_url(current_user)
    end    
  end
  
  def show
    collection = LoopCollection.find_by_id(params[:id])
    if collection
      @serialized_loop_collection = LoopCollection.active_model_serializer.new(collection, scope: serialization_scope)
      render :show            
    else
      flash[:errors] = ['That ring cannot be found.  The wise do not search, they have.']
      redirect_to :back
    end    
  end
  
  def destroy
    collection = LoopCollection.includes(:user).find_by_id(params[:id])
    
    if collection && collection.user == current_user
      collection.destroy      
      flash[:success] = ['Collection Destroyed.  The wise know that destruction is necessary.']
      redirect_to :back
    else
      flash[:error] = ['Unable to destroy such a thing. You may only let a bird free if you have it in your hand.']
      redirect_to :back      
    end
  end
  
end