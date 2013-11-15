TTR.Views.RandomButton = Backbone.View.extend({

  template: JST['random_button'],
  
  events: {
    "click #randomize-button":"toggleRandomize"
  },
  
  toggleRandomize: function(){
    TTR.playingRandomMode = (TTR.playingRandomMode ? false : true);
    this.render(); 
  },

  render: function(){
    var text = this.buttonText();
    var message = this.messageText();
    var renderedContent = this.template({ text: text, message: message });
    this.$el.html(renderedContent);
    this.setClass();
    this.$el.find('#randomize-button').tooltip();
    return this;
  },
  
  buttonText: function(){
    return (TTR.playingRandomMode ? "Normalize" : "Randomize")
  },
  
  messageText: function(){
    return (TTR.playingRandomMode ? "Click to lock all loops currently playing." : "Click to randomize all loops currently playing on loop end.")
  },
  
  setClass: function(){
    var classes = (TTR.playingRandomMode ? "btn btn-small" : "btn btn-small btn-inverse")
    this.$el.find('#randomize-button').removeClass().addClass(classes);
  },
    
});