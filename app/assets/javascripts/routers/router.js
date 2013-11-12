TTR.Routers.Router = Backbone.Router.extend({

  initialize: function($rootEl, loop_collection){
    this.$rootEl = $rootEl;
    this.loop_collection = new TTR.Models.LoopCollection(loop_collection, {parse: true});
  },

  routes: {
    '': "mainPlayer"
  },
  
  mainPlayer: function(){
    var view = new TTR.Views.Player({ model: this.loop_collection })
    
    this._switchView(view);
  },
  
  _switchView: function(newView){
    if(this.oldView){
      this.oldView.remove();
    }
    this.oldView = newView; 
    this.$rootEl.html( newView.render().$el );
  }
  
});
