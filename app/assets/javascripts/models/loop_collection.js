TTR.Models.LoopCollection = Backbone.Model.extend({
  urlRoot: "/api/loop_collections",
  
  parse: function (serverAttributes, options) {
    serverAttributes = serverAttributes.loop_collection
    this.collection = new TTR.Collections.Loops(serverAttributes.loops);
    var options = {loop_collection_id: serverAttributes.id}
    this.favorites = new TTR.Collections.Favorites(serverAttributes.favorites, options);
    
    delete serverAttributes.loops;
    delete serverAttributes.favorites;
    return serverAttributes;
  },
});