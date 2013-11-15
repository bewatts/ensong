class StaticPagesController < ApplicationController
  def root
    katie = nil
    katie_usernames = ['barnaclered', 'milliemelinda', 'melinda', 'kmillie']
    katie_usernames.each { |un| katie ||= User.includes(:loop_collections).find_by_username(un ) }
    collection = (katie && katie.loop_collections.first) ? katie.loop_collections.first : LoopCollection.first
    
    @serialized_loop_collection = LoopCollection.active_model_serializer.new(
                                                 collection, scope: serialization_scope)
    render :root
  end
end
