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
    var renderedContent = this.template({ text: text });
    this.$el.html(renderedContent);
    this.setClass();
    return this;
  },
  
  buttonText: function(){
    return (TTR.playingRandomMode ? "Normalize" : "Randomize")
  },
  
  setClass: function(){
    var classes = (TTR.playingRandomMode ? "btn btn-small" : "btn btn-small btn-inverse")
    this.$el.find('#randomize-button').removeClass().addClass(classes);
  },
    
});