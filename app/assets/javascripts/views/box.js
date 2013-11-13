TTR.Views.Box = Backbone.View.extend({
  events:{
    "click .blank": 'showOptions',
    "click .loop": 'playLoop',
    "click .stop": "stopPlaying",
    "mouseenter .blank": "toggleHighlight",
  },
  
  template: JST['box'],
  
  render: function(){
    var renderedContent = this.template();
    this.$el.html( renderedContent )
    return this;
  },
  
  toggleHighlight: function(){
    this.proxyEl().css("border-color", "silver");
    this.proxyEl().animate({
      "border-color": "white"
    }, 1000);
    
  },
  
  proxyEl: function(){ return this.$el.find('.box') },
  
  showOptions: function(event){
    this.proxyEl().css("border-color", "white");
    this.proxyEl().removeClass('blank');
    var options = new TTR.Views.LoopIndex({collection: this.collection});
    this.proxyEl().html( options.render().$el )
    this.unveil();
  },
  
  unveil: function(){
    var hidden_boxes = _.shuffle( $(".loop:hidden") )
    _.each(hidden_boxes, function(box){
      var delay = Math.floor( Math.random()*1500 + 1000 );
      $(box).fadeIn(delay);
    });
  },
  
  playLoop: function(event){
    var that = this
    this.color = $(event.currentTarget).css('backgroundColor')
    var loop_id = $(event.currentTarget).data('id')
    var loop = this.collection.get(loop_id);
    this.proxyEl().html(' ');  
    this.sound = new buzz.sound(loop.get("audio"));
    this.proxyEl().addClass('stop');
    this.setAnimation();
    this.sound.play().fadeIn();
  },
  
  setAnimation: function(){
    var that = this;
    this.sound.bind("playing", function(e){
      var time = 1000 * this.getDuration();
      that.proxyEl().css('background-color', 'white');  
      that.proxyEl().animate({
        backgroundColor: that.color,
      }, time, function(){
        that.proxyEl().css('background-color', 'white');          
      })
    });
    
    that.sound.bind("ended", function(){
      that.sound.play();
    });
  },
  
  stopPlaying: function(event){
    this.sound.unbind("playing ended").stop();
    this.proxyEl().stop();
    this.proxyEl().css('background-color', 'white');    
    this.proxyEl().removeClass('stop');
    this.proxyEl().addClass('blank');
  },
  
});