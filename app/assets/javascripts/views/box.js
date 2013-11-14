TTR.Views.Box = Backbone.View.extend({
  events:{
    "click .blank": 'showOptions',
    "click .loop": 'playLoop',
    "click .stop": "stopPlaying",
    "mouseenter .blank": "toggleHighlight",
    "mouseenter .loop": "toggleOpacity"
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
  
  
  toggleOpacity: function(event){
    $(event.currentTarget).css("opacity", "1");
    $(event.currentTarget).css("opacity", ".4");
    $(event.currentTarget).animate({
      "opacity": "1"
    }, 500)
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
      var delay = Math.floor( Math.random()*1000 + 500 );
      $(box).fadeIn(delay);
    });
  },
  
  playLoop: function(event){
    var that = this
    var loop_id = $(event.currentTarget).data('id')
    var loop = this.collection.get(loop_id);
    
    this.color = $(event.currentTarget).css('backgroundColor')
    this.sound = new buzz.sound(loop.get("audio"));    
    
    this.proxyEl().html(' ');  
    this.proxyEl().addClass('stop');
    
    this.modeSwitch();
  },
  
  modeSwitch: function(){
    (TTR.playingRandomMode) ? this.randomMode() : this.normalMode();
  },
  
  normalMode: function(){
    var that = this;
    that.sound.bind("ended", function(){
      TTR.playingRandomMode ? that.randomMode() : that.sound.play();
    });
    this.playSound();
  },
  
  randomMode: function(){
    var that = this;
    var randNum = Math.floor(Math.random()*this.collection.length);
    var new_loop = this.collection.models[randNum];
    
    this.sound = new buzz.sound(new_loop.get("audio"));
    
    this.color = $(".color-holder").removeClass().addClass('color-holder color' + randNum).css("background-color") 
    that.sound.bind("ended", function(){
      that.modeSwitch();
    });
    this.playSound();
  },
  
  playSound: function(){
    var that = this
    this.sound.bind("playing", function(e){
      var time = 1000 * this.getDuration();
      that.proxyEl().css('background-color', 'white');  
      that.proxyEl().animate({
        backgroundColor: that.color,
      }, time, function(){
        that.proxyEl().css('background-color', 'white');          
      });
    });
    this.sound.play().fadeIn();    
  },
  
  stopPlaying: function(event){
    var that = this;
    this.sound.unbind("playing ended").fadeOut(700, function(){
      that.sound.stop();
    });
    this.proxyEl().stop().css('background-color', 'white').removeClass('stop').addClass('blank');    
  },
  
});