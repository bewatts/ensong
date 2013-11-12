class StaticPagesController < ApplicationController
  def root
    @serialized_loop_collection = LoopCollection.active_model_serializer.new(
                                  LoopCollection.first, scope: serialization_scope)
    render :root
  end
end
