TTR.Views.LoopIndex = Backbone.View.extend({
  
  template: JST['loops/index'],
  
  className: 'full',
  
  render: function(){
    var renderedContent = this.template({loops: this.collection})
    this.$el.html(renderedContent);
    return this;
  },

});