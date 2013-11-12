TTR.Models.LoopCollection = Backbone.Model.extend({
  urlRoot: "/api/loop_collections",
  
  parse: function (serverAttributes, options) {
    serverAttributes = serverAttributes.loop_collection
    this.collection = new TTR.Collections.Loops(serverAttributes.loops);
    
    delete serverAttributes.loops;
    return serverAttributes;
  },
});