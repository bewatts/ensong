TTR.Collections.Favorites = Backbone.Collection.extend({
  model: TTR.Models.Favorite,
  
  url: 'api/favorites/',
  
  initialize: function(values, options){
    this.loopCollectionId = options.loop_collection_id;
  }
  
});