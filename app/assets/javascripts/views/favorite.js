TTR.Views.Favorite = Backbone.View.extend({
  
  template: JST['favorite'],
  
  events: {
    "click .btn-danger": "removeFavorite",
    "click .btn-success": "addFavorite"
  },
  
  render: function(){
    var renderedContent = this.template({ count: this.model.get('numFavorites') })
    this.$el.html(renderedContent);
    this.customizeButton();
    return this;
  },
  
  customizeButton: function(){
    var button = this.$el.find('a');
    if( this.model.get('isOwnedByCurrentUser') || this.model.get('userNotLoggedIn') ){
      button.attr('disabled', true);
    } else if ( this.model.get('isFavoritedByCurrentUser') ){
      button.removeClass();
      button.addClass('btn btn-small btn-danger');
    } else {
      button.removeClass();
      button.addClass('btn btn-small btn-success');
    }
  },
  
  addFavorite: function(){    
    var that = this;

    $.ajax({
      url: "/api/favorites",
      type: "POST",
      data: { loop_collection_id: that.model.id }
    });
    
    var newFavNum = this.model.get('numFavorites') + 1;
    this.model.set('numFavorites', newFavNum);
    this.model.set('isFavoritedByCurrentUser', true);

    this.render();
  },
  
  removeFavorite: function(){  
    var that = this;

    $.ajax({
      url: "/api/favorites/destroy",
      type: "DELETE",
      data: { 
        loop_collection_id: that.model.id 
      }
    })
    
    var newFavNum = this.model.get('numFavorites') - 1;
    this.model.set('numFavorites', newFavNum);
    this.model.set('isFavoritedByCurrentUser', false);
    this.render();
  },  
  
});