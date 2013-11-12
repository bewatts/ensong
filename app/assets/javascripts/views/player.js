TTR.Views.Player = Backbone.View.extend({

  template: JST['player'],
  
  numBoxes: 20,

  render: function(){
    var that = this;
    
    var renderedContent = this.template({ title: this.model.get('title') });
    this.$el.html(renderedContent);   
    
    var header = this.$el.find('#header');
    var header_view = new TTR.Views.PlayerHeader({ model: this.model });
    header.html( header_view.render().$el );
    
    var body = this.$el.find('#player');

    _.times(this.numBoxes, function(n){
      var box = new TTR.Views.Box({ collection: that.model.collection })
      body.append( box.render().$el )
    });
    return this;
  },
  
  unveil: function(){
    var hidden_boxes = _.shuffle( $(".box:hidden") )
    _.each(hidden_boxes, function(box){
      var delay = Math.floor( Math.random()*2500 + 1000 );
      $(box).fadeIn(delay);
    });
  }
  
});