window.TTR = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($rootEl, loops) {
    this.router = new TTR.Routers.Router($rootEl, loops);
    Backbone.history.start();
  }
};

$(document).ready(function(){
  var $rootEl = $('#content')
  var loop_collection = JSON.parse($('#bootstrapped_loop_collection').html())
  
  if ($rootEl.length > 0){
    TTR.initialize($rootEl, loop_collection);
  };
  
});
