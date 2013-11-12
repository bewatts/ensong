class Api::LoopCollectionsController < ApplicationController
  include Api::LoopCollectionsHelper
  
  def show
    @loop_collection = LoopCollection.includes(:loops).find_by_id(params[:id])
    render :json => @loop_collection, scope: serialization_scope
  end
  
  def index
    @loop_collection = LoopCollection.includes(:loops).all
    render :json => @loop_collection, scope: serialization_scope    
  end
  
  def default_serializer_options
    { root: false }
  end
  
end