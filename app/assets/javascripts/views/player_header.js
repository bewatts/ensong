TTR.Views.PlayerHeader = Backbone.View.extend({

  template: JST['player_header'],

  render: function(){
    var un = this.model.get('user').username;
    var id = this.model.id;
    var title = this.model.get('title');
    var renderedContent = this.template({ title: title, username: un, loop_collection_id: id });
    var favoriteView = new TTR.Views.Favorite({ model: this.model });
    var randomButtonView = new TTR.Views.RandomButton();
    
    this.$el.html(renderedContent);
    this.$el.find('#fav').html( favoriteView.render().$el )
    this.$el.find('#rand').html( randomButtonView.render().$el )
    return this;
  },
    
});