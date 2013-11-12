TTR.Views.Box = Backbone.View.extend({
  events:{
    "click .blank": 'showOptions',
    "click .loop": 'playLoop',
    "click .stop": "stopPlaying"
  },
  
  template: JST['box'],
  
  render: function(){
    var renderedContent = this.template();
    this.$el.html( renderedContent )
    return this;
  },
  
  proxyEl: function(){ return this.$el.find('.box') },
  
  showOptions: function(event){
    this.proxyEl().removeClass('blank');
    var options = new TTR.Views.LoopIndex({collection: this.collection});
    this.proxyEl().html( options.render().$el )
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
      }, time )
    });
    
    that.sound.bind("ended", function(){
      that.sound.play();
    });
  },
  
  stopPlaying: function(event){
    this.sound.unbind("playing ended").stop();
    this.proxyEl().stop();
    this.proxyEl().css('background-color', 'black');    
    this.proxyEl().removeClass('stop');
    this.proxyEl().addClass('blank');
  },
  
});